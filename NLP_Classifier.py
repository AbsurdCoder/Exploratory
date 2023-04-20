import pandas as pd
import numpy as np
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, classification_report


def load_and_preprocess_data(file_path):
    # Load the dataset
    data = pd.read_csv(file_path)
    
    # Preprocess the text
    lemmatizer = WordNetLemmatizer()
    nltk.download('stopwords')
    nltk.download('wordnet')
    stop_words = set(stopwords.words('english'))

    def preprocess_text(text):
        text = re.sub(r'\W', ' ', text.lower())
        text = re.sub(r'\s+', ' ', text).strip()
        tokens = text.split()
        tokens = [lemmatizer.lemmatize(token) for token in tokens if token not in stop_words]
        return ' '.join(tokens)

    data['preprocessed_text'] = data['incident_description'].apply(preprocess_text)
    
    return data


def prepare_data(data):
    # Extract features and split the dataset
    vectorizer = TfidfVectorizer(max_features=1000)

    X = vectorizer.fit_transform(data['preprocessed_text']).toarray()
    y = data['incident_category']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    return X_train, X_test, y_train, y_test


def train_and_evaluate_model(X_train, X_test, y_train, y_test):
    # Train and evaluate the model
    model = MultinomialNB()
    model.fit(X_train, y_train)
    
    y_pred = model.predict(X_test)
    
    print("Accuracy:", accuracy_score(y_test, y_pred))
    print("Classification Report:\n", classification_report(y_test, y_pred))


file_path = "data.csv"  # Replace with the path to your dataset
data = load_and_preprocess_data(file_path)
X_train, X_test, y_train, y_test = prepare_data(data)
train_and_evaluate_model(X_train, X_test, y_train, y_test)
