import torch
import pandas as pd
from sklearn.model_selection import train_test_split
from pytorch_forecasting import TimeSeriesDataSet, TemporalFusionTransformer
from pytorch_forecasting.data import GroupNormalizer
from pytorch_forecasting.metrics import SMAPE, MAE, RMSE
from pytorch_forecasting.models.temporal_fusion_transformer.tuning import optimize_hyperparameters

# Load and preprocess your data
# Assuming you have a pandas DataFrame 'df' with columns 'timestamp', 'group', and 'message_volume'
# df = pd.read_csv("your_data.csv")

# Add time index and group columns
df["time_idx"] = (df.timestamp - df.timestamp.min()) / pd.Timedelta("1h")
df["time_idx"] = df["time_idx"].round().astype(int)

# Split the data into training and validation sets
train_df, val_df = train_test_split(df, test_size=0.2, shuffle=False)

# Create a dataset
max_prediction_length = 24
max_encoder_length = 72
training_cutoff = train_df["time_idx"].max() - max_prediction_length

context_length = max_encoder_length
prediction_length = max_prediction_length

training = TimeSeriesDataSet(
    train_df,
    time_idx="time_idx",
    target="message_volume",
    group_ids=["group"],
    min_encoder_length=context_length,
    max_encoder_length=context_length,
    min_prediction_length=prediction_length,
    max_prediction_length=prediction_length,
    static_categoricals=[],
    static_reals=[],
    time_varying_known_categoricals=[],
    time_varying_known_reals=["time_idx"],
    time_varying_unknown_categoricals=[],
    time_varying_unknown_reals=["message_volume"],
    target_normalizer=GroupNormalizer(groups=["group"], transformation="softplus"),
    add_relative_time_idx=True,
    add_target_scales=True,
    add_encoder_length=True,
)

validation = TimeSeriesDataSet.from_dataset(training, val_df, stop_randomization=True)

# Create a dataloader
batch_size = 128
train_dataloader = training.to_dataloader(train=True, batch_size=batch_size, num_workers=0)
val_dataloader = validation.to_dataloader(train=False, batch_size=batch_size, num_workers=0)

# Define a custom loss function
class WeightedLoss(torch.nn.Module):
    def __init__(self, non_zero_weight: float = 10.0):
        super().__init__()
        self.non_zero_weight = non_zero_weight

    def forward(self, y_pred, y_true):
        weights = torch.where(y_true.abs() > 1e-12, torch.ones_like(y_true) * self.non_zero_weight, torch.ones_like(y_true))
        loss = torch.abs(y_pred - y_true)
        weighted_loss = weights * loss
        return weighted_loss.mean()
