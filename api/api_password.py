from flask import Flask, request, jsonify
import re
import joblib
from sklearn.ensemble import RandomForestClassifier
import numpy as np

app = Flask(__name__)

# Simulando um modelo de ML pré-treinado
# Aqui utilizaremos um modelo RandomForest simples para ilustrar o conceito
# Em um caso real, o modelo seria treinado com dados sobre ataques cibernéticos e padrões de senhas

# Treinando o modelo com dados fictícios para fins de exemplo
def train_model():
    # Dados de exemplo (neste caso, fictícios) com características de senhas
    X_train = np.array([
        [8, 1, 1, 1, 0],  # Exemplo de senha fraca
        [12, 1, 1, 1, 1], # Exemplo de senha moderada
        [15, 1, 1, 1, 1], # Exemplo de senha forte
        [6, 0, 0, 1, 0]   # Exemplo de senha muito fraca
    ])
    y_train = np.array([0, 1, 1, 0])  # 0 = Vulnerável, 1 = Segura
    
    model = RandomForestClassifier()
    model.fit(X_train, y_train)
    
    joblib.dump(model, 'password_model.pkl')
    return model

# Carrega ou treina o modelo
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

# Rota para avaliar a força da senha
@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.get_json()
    password = data.get('password')
    
    if not password:
        return jsonify({'error': 'Senha não fornecida'}), 400
    
    strength = analyze_password_strength(password)
    return jsonify(strength)

# Rota para prever vulnerabilidade da senha usando o modelo de ML
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
