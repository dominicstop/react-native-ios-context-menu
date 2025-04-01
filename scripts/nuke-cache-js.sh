
#!/bin/bash

# NOTE:
# assumes the script is run on repo root

SCRIPT_BASE_URL="https://raw.githubusercontent.com/dominicstop/react-native-ios-utilities/refs/heads/master/scripts"

# E.g. delete-version.sh
SCRIPT_NAME=$(basename "$0")

SCRIPT_URL="${SCRIPT_BASE_URL}/${SCRIPT_NAME}"
TEMP_SCRIPT_NAME="temp-$SCRIPT_NAME"
TEMP_SCRIPT_PATH="/tmp/$TEMP_SCRIPT_NAME"

echo "Script Repo URL: $SCRIPT_BASE_URL"
echo "Script: $SCRIPT_NAME"

echo "Fetching script..."
curl -s $SCRIPT_URL -o $TEMP_SCRIPT_PATH
chmod +x $TEMP_SCRIPT_PATH

echo "Executing script: $TEMP_SCRIPT_PATH"
$TEMP_SCRIPT_PATH ; 

rm -f $TEMP_SCRIPT_PATH