#set env vars
set -o allexport; source .env; set +o allexport;

echo "Waiting for Metabase to be ready"
sleep 240s;

app_target=$(docker-compose port metabase 3000)

export SETUP_TOKEN=$(curl -s -m 5 -X GET -H "Content-Type: application/json" http://$app_target/api/session/properties | jq -r '.["setup-token"]')

curl --header "Content-Type: application/json" \
http://$app_target/api/setup \
 --request POST -d '{
    "token": "'${SETUP_TOKEN}'",
    "user": {
        "email": "'${ADMIN_EMAIL}'",
        "first_name": "Metabase",
        "last_name": "Admin",
        "password": "'${ADMIN_PASSWORD}'",
        "password_confirm": "'${ADMIN_PASSWORD}'",
        "site_name": "Metabase Instance"
    },
    "prefs": {
        "allow_tracking": false,
        "site_name": "Metabase Instance",
        "site_locale": "en"
    }
}'







