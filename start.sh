#!/bin/bash

set -e

# Make sure the agent is unregistered when it's stopped
cleanup() {
  echo "Cleaning up..."
  ./bin/Agent.Listener remove --unattended \
    --auth PAT \
    --token $AZP_TOKEN
}

# Catch termination signals
trap 'cleanup; exit 130' SIGINT
trap 'cleanup; exit 143' SIGTERM

# Configure the agent
./config.sh --unattended \
  --agent "${AZP_AGENT_NAME:-$(hostname)}" \
  --url "$AZP_URL" \
  --auth PAT \
  --token "$AZP_TOKEN" \
  --pool "${AZP_POOL:-Default}" \
  --work "_work" \
  --replace

# Run the agent
./run.sh & wait $!
