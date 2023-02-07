#set env vars
set -o allexport; source .env; set +o allexport;

echo "Waiting for Metabase to be ready"
sleep 120s;

app_target=$(docker-compose port metabase 3000)

  echo "app_target"
  echo "------------------------"
  echo $app_target
  echo "------------------------"


curl http://$app_target/api/session/properties \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --compressed --connect-timeout 120

    echo "2eme sleep";
  sleep 10s;


properties=$(curl http://$app_target/api/session/properties \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --compressed)

  echo "properties"
  echo "------------------------"
  echo $properties
  echo "------------------------"


token=$(echo properties | jq -r '.["setup-token"]')

echo "token"
  echo "------------------------"
  echo $token
  echo "------------------------"


curl http://$app_target/api/setup \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"token":"'${token}'","user":{"password_confirm":"'${ADMIN_PASSWORD}'","password":"'${ADMIN_PASSWORD}'","site_name":"Metabase Instance","email":"'${ADMIN_EMAIL}'","last_name":"Admin","first_name":"Metabase"},"database":null,"invite":null,"prefs":{"site_name":"Metabase Instance","site_locale":"en","allow_tracking":"false"}}' \
  --compressed









# export SETUP_TOKEN=$(curl -s -m 5 -X GET -H "Content-Type: application/json" http://$app_target/api/session/properties | jq -r '.["setup-token"]')

# echo ${SETUP_TOKEN}

# curl --header "Content-Type: application/json" \
# http://$app_target/api/setup \
#  --request POST -d '{
#     "token": "'${SETUP_TOKEN}'",
#     "user": {
#         "email": "'${ADMIN_EMAIL}'",
#         "first_name": "Metabase",
#         "last_name": "Admin",
#         "password": "'${ADMIN_PASSWORD}'",
#         "password_confirm": "'${ADMIN_PASSWORD}'",
#         "site_name": "Metabase Instance"
#     },
#     "prefs": {
#         "allow_tracking": false,
#         "site_name": "Metabase Instance",
#         "site_locale": "en"
#     }
# }'
