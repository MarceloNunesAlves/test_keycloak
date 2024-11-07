import requests
import json

KEYCLOAK_URL="http://localhost:8080"
KEYCLOAK_MAIN_REALM="master"
KEYCLOAK_USER="admin"
KEYCLOAK_PASSWORD="admin"

# URL da requisição
url = f"{KEYCLOAK_URL}/realms/{KEYCLOAK_MAIN_REALM}/protocol/openid-connect/token"

data = {"client_id": "admin-cli",
        "username": KEYCLOAK_USER,
        "password": KEYCLOAK_PASSWORD,
        "grant_type": "password",
        "scope": "openid"}

print(url)
print('http://localhost:8080/realms/master/protocol/openid-connect/token')
# Fazendo a requisição com autenticação básica
response = requests.post(url, data=data)

if response.status_code == 200:
    print("Requisição bem-sucedida")
    print("Resposta:")
    print(response.json())

    access_token = response.json()['access_token']
    print(access_token)

else:
    print(response)
