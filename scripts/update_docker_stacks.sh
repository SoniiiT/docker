#!/bin/bash

# ==============================================================================
# CONFIGURATION
# ==============================================================================

# List of stack directories to manage
STACKS=(
  # Headscale / Headplane on cloud-srv-03
  "/opt/docker-stack/cloud-srv-03/headscale"
  "/opt/docker-stack/cloud-srv-03/headplane"
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

# Iterate through all defined stacks
for DIR in "${STACKS[@]}"; do
    echo "----------------------------------------------------------------"
    echo "Checking Stack: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "[ERROR] Directory $DIR does not exist. Skipping."
        continue
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
        docker compose up -d --remove-orphans
        docker image prune -f
        echo "[SUCCESS] Update completed."
    fi
done
echo "----------------------------------------------------------------"
