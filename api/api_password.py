from flask import Flask, request, jsonify
import re
import joblib
from sklearn.ensemble import RandomForestClassifier
import numpy as np

app = Flask(__name__)

def train_model():
    X_train = np.array([
        [8, 1, 1, 1, 0],  
        [12, 1, 1, 1, 1], 
        [15, 1, 1, 1, 1], 
        [6, 0, 0, 1, 0]   
    ])
    y_train = np.array([0, 1, 1, 0])
    
    model = RandomForestClassifier()
    model.fit(X_train, y_train)
    
    joblib.dump(model, 'password_model.pkl')
    return model

try:
    model = joblib.load('password_model.pkl')
except:
    model = train_model()

# Função para avaliar a força de uma senha
def analyze_password_strength(password):
    length = len(password)
    has_upper = int(bool(re.search(r'[A-Z]', password)))
    has_lower = int(bool(re.search(r'[a-z]', password)))
    has_digit = int(bool(re.search(r'\d', password)))
    has_special = int(bool(re.search(r'[@$!%*?&#]', password)))
    
    return {
        'length': length,
        'has_upper': has_upper,
        'has_lower': has_lower,
        'has_digit': has_digit,
        'has_special': has_special
    }

@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.get_json()
    password = data.get('password')
    
    if not password:
        return jsonify({'error': 'Senha não fornecida'}), 400
    
    strength = analyze_password_strength(password)
    return jsonify(strength)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    password = data.get('password')
    
    if not password:
        return jsonify({'error': 'Senha não fornecida'}), 400
    
    strength = analyze_password_strength(password)
    features = np.array([[strength['length'], strength['has_upper'], strength['has_lower'], strength['has_digit'], strength['has_special']]])
    prediction = model.predict(features)[0]
    
    return jsonify({'vulnerability': 'Segura' if prediction == 1 else 'Vulnerável'})

if __name__ == '__main__':
    app.run(debug=True)
