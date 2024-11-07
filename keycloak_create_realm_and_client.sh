#!/bin/zsh

# don't forget to update below variables to point to your Keycloak instance, main realm, and admin user
KEYCLOAK_URL="http://localhost:8080"
KEYCLOAK_MAIN_REALM="master"
KEYCLOAK_USER="admin"
KEYCLOAK_PASSWORD="admin"

echo "$KEYCLOAK_URL/realms/$KEYCLOAK_MAIN_REALM/protocol/openid-connect/token"
echo "username=$KEYCLOAK_USER"
echo "password=$KEYCLOAK_PASSWORD"

# get the access token
access_token=$(curl -v --location "$KEYCLOAK_URL/realms/$KEYCLOAK_MAIN_REALM/protocol/openid-connect/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=admin-cli" \
--data-urlencode "username=$KEYCLOAK_USER" \
--data-urlencode "password=$KEYCLOAK_PASSWORD" \
--data-urlencode "grant_type=password" \
--data-urlencode "scope=openid" | jq -r '.access_token')

echo "Token gerado ******"
echo $access_token
echo "*******************"

  # create customer100 realm
 curl -v -X POST -H "Authorization: bearer $access_token" -H "Content-Type: application/json" --data-binary @new_realm.json $KEYCLOAK_URL/admin/realms

 # check if realm created successfully
 curl -H "Authorization: bearer $access_token" $KEYCLOAK_URL/admin/realms/customer100 | jq

 # create react client
 curl -v -X POST -H "Authorization: bearer $access_token" -H "Content-Type: application/json" --data-binary @new_client.json $KEYCLOAK_URL/admin/realms/customer100/clients

 # check if client created successfully
 curl -H "Authorization: bearer $access_token" $KEYCLOAK_URL/admin/realms/customer100/clients?clientId=react | jq
