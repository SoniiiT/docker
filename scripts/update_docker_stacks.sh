#!/bin/bash

# ==============================================================================
# CONFIGURATION
# ==============================================================================

# Path to the secrets file
SECRETS_FILE="/root/.doppler_secrets"

# List of Stacks: "Path to folder" -> "Variable Name in secrets file"
declare -A STACKS
STACKS=(
  # BEISPIEL LXC (Zeile einkommentieren & anpassen):
  # ["/opt/docker-stack/LXC-Semaphore"]="DOPPLER_TOKEN"

  # BEISPIEL DOCKER SERVER (Zeilen einkommentieren & anpassen):
  # ["/opt/docker/paperless"]="DOPPLER_TOKEN_PAPERLESS"
  # ["/opt/docker/nginx"]="DOPPLER_TOKEN_NGINX"

  # BEISPIEL OHNE DOPPLER (einfach leer lassen):
  # ["/opt/docker/simple-service"]=""
)

# ==============================================================================
# LOGIC
# ==============================================================================

# Check for --start flag
FORCE_START=false
for arg in "$@"; do
    if [ "$arg" == "--start" ]; then
        FORCE_START=true
        break
    fi
done

# 1. Load Secrets
if [ -f "$SECRETS_FILE" ]; then
    source "$SECRETS_FILE"
else
    echo "[ERROR] Secrets file $SECRETS_FILE not found."
    exit 1
fi

# 2. Iterate through all defined stacks
for DIR in "${!STACKS[@]}"; do
    VAR_NAME="${STACKS[$DIR]}"
    TOKEN=""

    echo "----------------------------------------------------------------"
    echo "Checking Stack: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "[ERROR] Directory $DIR does not exist. Skipping."
        continue
    fi

    # Only try to resolve token if a variable name is configured
    if [ -n "$VAR_NAME" ]; then
        TOKEN="${!VAR_NAME}"
        
        if [ -z "$TOKEN" ]; then
            echo "[ERROR] Token variable '$VAR_NAME' is empty or not set. Skipping."
            continue
        fi
    fi

    cd "$DIR" || continue

    echo "Executing git pull..."
    GIT_OUTPUT=$(git pull 2>&1)
    GIT_EXIT_CODE=$?

    if [ $GIT_EXIT_CODE -ne 0 ]; then
        echo "[ERROR] Git pull failed:"
        echo "$GIT_OUTPUT"
        continue
    fi

    if [[ "$GIT_OUTPUT" == *"Already up to date."* ]] && [ "$FORCE_START" = false ]; then
        echo "[INFO] No changes in Git."
    else
        if [ "$FORCE_START" = true ]; then
            echo "[INFO] --start flag detected. Forcing start..."
        else
            echo "[INFO] Changes detected. Starting update..."
        fi
        
        docker compose pull
        
        if [ -n "$TOKEN" ]; then
            # Run update with specific token
            export DOPPLER_TOKEN="$TOKEN"
            doppler run -- docker compose up -d --remove-orphans
        else
            # Run update without Doppler
            docker compose up -d --remove-orphans
        fi
        
        docker image prune -f
        echo "[SUCCESS] Update completed."
    fi
done
echo "----------------------------------------------------------------"
