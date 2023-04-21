import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from datetime import timedelta
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_absolute_error
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, LSTM

# Custom function to generate business days with 15-min intervals
def business_days_with_intervals(start_date, periods, interval):
    date_range = []
    current_date = pd.Timestamp(start_date)
    while len(date_range) < periods:
        if current_date.weekday() < 5:  # Weekdays only (0: Monday, 1: Tuesday, ..., 4: Friday)
            date_range.append(current_date)
        current_date += timedelta(minutes=interval)
    return pd.DatetimeIndex(date_range)

# Generate random time series data (Replace this with your own data)
np.random.seed(0)
n = 3240  # 3 months of 15-min intervals for weekdays only (5 days a week)
t = np.arange(n)
trend = 0.001 * t
seasonal = np.sin(2 * np.pi * t / 80)  # 80 15-min intervals make a weekday
noise = 0.1 * np.random.randn(n)
volume = trend + seasonal + noise
volume[volume < 0] = 0  # Remove negative values

# Convert the generated data to a pandas Series with a datetime index (excluding weekends)
dates = business_days_with_intervals(start_date='2023-01-01', periods=n, interval=15)
time_series = pd.Series(volume, index=dates)

# Split the data into training and testing sets
train_size = int(n * 0.8)
train, test = time_series.iloc[:train_size], time_series.iloc[train_size:]

# Normalize the data using MinMaxScaler
scaler = MinMaxScaler()
train = scaler.fit_transform(train.values.reshape(-1, 1))
test = scaler.transform(test.values.reshape(-1, 1))

# Create input and output sequences for the LSTM model
seq_length = 80
x_train, y_train = create_sequences(train, seq_length)
x_test, y_test = create_sequences(test, seq_length)

# Build the LSTM model
model = Sequential()
model.add(LSTM(50, activation='relu', input_shape=(seq_length, 1)))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mean_squared_error')

# Train the model
model.fit(x_train, y_train, epochs=100, batch_size=32)

# Predict the volume count for the test set
y_pred = model.predict(x_test)

# Rescale the predictions
y_test = scaler.inverse_transform(y_test)
y_pred = scaler.inverse_transform(y_pred)

# Evaluate the model
mae = mean_absolute_error(y_test, y_pred)
print(f"Mean Absolute Error: {mae}")

# Plot the actual vs predicted values
plt.plot(y_test, label='Actual')
plt.plot(y_pred, label='Predicted')
plt.legend()
plt.show()
