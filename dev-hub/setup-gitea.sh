#!/bin/bash
set -x

# Set your Gitea server URL and credentials
GITEA_URL="http://gitea:3000"
# OAuth application details
OAUTH_APP_NAME="RH_Dev_Hub"
OAUTH_REDIRECT_URI="http://localhost:7007/api/auth/github/handler/frame"
OAUTH_SCOPES="read_user, admin"
ADMIN_USERNAME=$RHDEVHUBUSER
ADMIN_PASSWORD=$RHDEVHUBPWD
OAUTH_RESPONSE_JSON_FILE="/scripts/.oauthapp_info_json"

update_yaml_fields() {
    local input_yaml="$1"
    local output_yaml="$2"
    local new_client_id="$3"
    local new_client_secret="$4"

    # Update clientId and clientSecret using yq
    yq eval ".auth.providers.github.development.clientId = \"$new_client_id\" | .auth.providers.github.development.clientSecret = \"$new_client_secret\"" "$input_yaml" > "$output_yaml"

    echo "clientId and clientSecret updated successfully. Updated YAML saved to $output_yaml."
}


create_oauth_app() {

# Create an OAuth application
AUTH_HEADER=$(echo -n "$ADMIN_USERNAME:$ADMIN_PASSWORD" | base64)
OAUTH_RESPONSE=$(curl "${GITEA_URL}/api/v1/user/applications/oauth2" \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: Basic ${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  --data-raw "{
    \"confidential_client\": false,
    \"name\": \"${OAUTH_APP_NAME}\",
    \"redirect_uris\": [
      \"${OAUTH_REDIRECT_URI}\"
    ]
  }")
echo "$OAUTH_RESPONSE" > $OAUTH_RESPONSE_JSON_FILE
# Extract the OAuth application's client ID and client secret
CLIENT_ID=$(echo "$OAUTH_RESPONSE" | jq -r '.client_id')
CLIENT_SECRET=$(echo "$OAUTH_RESPONSE" | jq -r '.client_secret')

# Display information
echo "OAuth Application $OAUTH_APP_NAME created:"
echo "Client ID: $CLIENT_ID"
echo "Client Secret: $CLIENT_SECRET"

#Time to update the client ID and secret for RH Dev Hub to start 
#We need to write to a new file to ensure the auth-config.yaml 
#is not checked into into git 
input_yaml="/scripts/auth-config.yaml.template"
output_yaml="/scripts/auth-config.yaml"
new_client_id="$CLIENT_ID"
new_client_secret="$CLIENT_SECRET"

# Check if the output file already exists
if [ ! -f "$output_yaml" ]; then
  update_yaml_fields "$input_yaml" "$output_yaml" "$new_client_id" "$new_client_secret"
else
  echo "Output file '$output_yaml' already exists. Skipping update."
fi

}


# Check if the JSON file is not present or empty
if [ ! -s "$OAUTH_RESPONSE_JSON_FILE" ]; then
  create_oauth_app 
else
  echo "Access token already exists. Skipping"
fi


