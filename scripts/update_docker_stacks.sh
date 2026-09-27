#!/bin/bash
# ==============================================================================
# update_docker_stacks.sh - Robust version
# Source of truth: https://github.com/SoniiiT/docker (scripts/update_docker_stacks.sh)
#
# Fixes "git pull fails on dirty checkout":
#   Generated Traefik symlinks (_svc__*) and local config edits make the
#   /opt/docker-stack checkout dirty, so a plain `git pull` aborts.
#   This version stashes local modifications, cleans generated files, pulls,
#   restores local changes, then re-runs relink.sh so Traefik reloads config.
#
# NOTE: Local uncommitted changes are stashed (git stash), never lost.
#       Check `git stash list` on the host to restore them manually if needed.
#
# Per-host configuration:
#   STACKS  - list of stack dirs to deploy (edit for each host)
#   RELINK  - optional path to relink.sh (Traefik host only); empty on others
# ==============================================================================

# CONFIGURATION (adjust per host)
STACKS=(
  # Headscale / Headplane on cloud-srv-03
  "/opt/docker-stack/cloud-srv-03/headscale"
  "/opt/docker-stack/cloud-srv-03/headplane"
)

REPO="/opt/docker-stack"
GIT="/usr/bin/git"

# Traefik host only: path to relink.sh that regenerates _svc__* symlinks.
# Leave empty on hosts that do not run Traefik.
RELINK="$REPO/docker-srv-01/traefik/relink.sh"

# ==============================================================================
# LOGIC
# ==============================================================================

FORCE_START=false
for arg in "$@"; do
    if [ "$arg" == "--start" ]; then
        FORCE_START=true
        break
    fi
done

if [ ! -d "$REPO/.git" ]; then
    echo "[ERROR] $REPO is not a git checkout. Exiting."
    exit 1
fi

# Make git accept this repo regardless of owner (fixes "dubious ownership")
"$GIT" config --global --add safe.directory "$REPO" 2>/dev/null || true

echo "==> Cleaning dirty state in $REPO ..."

# Stash local modifications to tracked files (preserves Tony's work)
cd "$REPO" || exit 1
HAD_STASH=false
if ! "$GIT" diff --quiet 2>/dev/null; then
    "$GIT" stash push -m "auto-stash by update_docker_stacks $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1 && HAD_STASH=true
fi

# Remove generated Traefik symlinks (_svc__*) that are untracked and would
# conflict with a pull; relink.sh regenerates them afterwards.
find "$REPO" -maxdepth 4 -name '_svc__*' -delete 2>/dev/null || true

echo "==> Pulling latest from origin/main ..."
PULL_OUTPUT=$("$GIT" pull --rebase origin main 2>&1)
PULL_EXIT=$?
echo "$PULL_OUTPUT"

if [ $PULL_EXIT -ne 0 ]; then
    echo "[ERROR] Git pull failed. Restoring local changes (stash)."
    "$GIT" stash pop 2>/dev/null || true
    exit 1
fi

# Restore local modifications that were stashed (if any)
if [ "$HAD_STASH" = true ]; then
    echo "==> Restoring local modifications (git stash pop)..."
    "$GIT" stash pop 2>&1 || echo "[WARN] Stash pop had conflicts - check 'git stash list'"
fi

# Regenerate Traefik symlinks so configs are picked up
if [ -n "$RELINK" ] && [ -f "$RELINK" ]; then
    echo "==> Regenerating Traefik dynamic symlinks..."
    bash "$RELINK" 2>&1 || true
fi

# ==============================================================================
# Deploy stacks
# ==============================================================================
for DIR in "${STACKS[@]}"; do
    echo "----------------------------------------------------------------"
    echo "Checking Stack: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "[ERROR] Directory $DIR does not exist. Skipping."
        continue
    fi

    cd "$DIR" || continue
    echo "==> docker compose pull"
    docker compose pull 2>&1 || echo "[WARN] pull failed for $DIR"
    echo "==> docker compose up -d"
    docker compose up -d --remove-orphans 2>&1 || echo "[WARN] up failed for $DIR"
    docker image prune -f 2>/dev/null || true
    echo "[SUCCESS] Update completed for $DIR"
done
echo "----------------------------------------------------------------"
