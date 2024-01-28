#!/bin/bash
# Start Gitea

generate_access_token() {
  local username="$1"
  local token_file="$2"

  echo "Generating access token..."
  
  # Generate access token and store it in the specified file
  local access_token
  access_token=$(gitea admin user generate-access-token --token-name drh-admin --username "$username" --scopes "write:user,write:admin,write:repository")
  echo "$access_token" | tail -1 | cut -d":" -f2 > "$token_file"
  echo "Access token generated and stored successfully."
}

gitea web &

ACCESS_TOKEN_FILE="/scripts/.accesstoken"

# Wait for Gitea to start
until curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/ | grep 200; do
    echo "Waiting for Gitea to start..."
    sleep 5
done

# Run additional commands
echo "Running additional commands after Gitea has started"
# Add your additional commands here

echo "Creating Admin user"
gitea admin user create --username $RHDEVHUBUSER --password $RHDEVHUBPWD --email rhdevhub@example.com --admin true
echo "Admin user Created"
# Check if the .accesstoken file is not present or empty
if [ ! -s "$ACCESS_TOKEN_FILE" ]; then
  generate_access_token "$RHDEVHUBUSER" "$ACCESS_TOKEN_FILE"
else
  echo "Access token already exists. Skipping"
fi
# Keep the script running to keep the container alive
tail -f /dev/null
