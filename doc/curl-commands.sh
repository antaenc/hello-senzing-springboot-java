#!/usr/bin/env bash 

# Set environment variables, if not already set.

if [ -z "${SENZING_DEMO_URL}" ]; then
  export SENZING_DEMO_URL="http://localhost:8080"
fi

if [ -z "${SENZING_DEMO_DATASOURCE}" ]; then
  export SENZING_DEMO_DATASOURCE="test-datasource"
fi

# Preface

echo "Using URL" ${SENZING_DEMO_URL}

# Print curl commands to STDOUT

set -o xtrace

# Get workload statistics

curl -X GET \
  ${SENZING_DEMO_URL}/stats | jq .

# Get configuration

curl -X GET \
  ${SENZING_DEMO_URL}/export-config | jq .

# Add records

curl -X POST \
  --header "Content-Type: application/json" \
  --data '{"record": "astring"}' \
  ${SENZING_DEMO_URL}/add-record/${SENZING_DEMO_DATASOURCE} | jq .
