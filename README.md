# AEP2
Para rodar corretamente o projeto é necessário executar os seguintes comandos para instalar as bibliotecas:<br>
    - pip install flask<br>
    - pip install scikit-learn<br>
    - pip install joblib<br>

from flask import Flask, request, jsonify
from flask_cors import CORS

import re
import joblib
from sklearn.ensemble import RandomForestClassifier
import numpy as np