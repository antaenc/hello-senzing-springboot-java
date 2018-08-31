#!/usr/bin/env bash

# APIs tested.  "Y" for yes, "N" for no.
# Y POST /add-record/{dataSource}
# Y POST /add-record/{dataSource}/{recordID}
# Y DELETE /delete-record/{dataSource}/{recordID}
# Y GET /export-config
# N GET /get-entity-by-entity-id/{entityID}
# N GET /get-entity-by-record-id/{dataSource}/{recordID}
# Y GET /get-record/{dataSource}/{recordID}
# N POST /purge-repository
# Y POST /replace-record/{dataSource}/{recordID}
# Y GET /search-by-attributes
# Y GET /stats

# Set environment variables, if not already set.

if [ -z "${SENZING_DEMO_URL}" ]; then
  export SENZING_DEMO_URL="http://localhost:8080"
fi

if [ -z "${SENZING_DEMO_DATASOURCE}" ]; then
  export SENZING_DEMO_DATASOURCE="TEST"
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
# CAVEAT: HTTP response body is not JSON.
# $RECORD_ID will contain the record ID returned from curl call.

RECORD_ID=$(curl -X POST \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data "{\"NAME_TYPE\": \"PRIMARY\", \"NAME_FIRST\": \"JANE\", \"NAME_LAST\": \"SMITH\", \"ADDR_TYPE\": \"HOME\", \"ADDR_LINE1\": \"653 STATE ROUTE 7\", \"ADDR_CITY\": \"FRESNO\", \"ADDR_STATE\": \"CA\", \"ADDR_POSTAL_CODE\": \"55073-1234\"}" \
  ${SENZING_DEMO_URL}/add-record/${SENZING_DEMO_DATASOURCE})

## Get the data from the record just created.

curl -X GET \
  ${SENZING_DEMO_URL}/get-record/${SENZING_DEMO_DATASOURCE}/${RECORD_ID} | jq .

# Rename "JANE" to "JANET".

curl -X POST \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data "{\"NAME_TYPE\": \"PRIMARY\", \"NAME_FIRST\": \"JANET\", \"NAME_LAST\": \"SMITH\", \"ADDR_TYPE\": \"HOME\", \"ADDR_LINE1\": \"653 STATE ROUTE 7\", \"ADDR_CITY\": \"FRESNO\", \"ADDR_STATE\": \"CA\", \"ADDR_POSTAL_CODE\": \"55073-1234\"}" \
  ${SENZING_DEMO_URL}/replace-record/${SENZING_DEMO_DATASOURCE}/${RECORD_ID}

# Get the data from the record just modified.

curl -X GET \
  ${SENZING_DEMO_URL}/get-record/${SENZING_DEMO_DATASOURCE}/${RECORD_ID} | jq .

# Query by attribute.
# CAVEAT: Query does not return results.  Why?

QUERY_STRING="{\"NAME_TYPE\": \"PRIMARY\", \"NAME_FIRST\": \"JANET\", \"NAME_LAST\": \"SMITH\", \"ADDR_TYPE\": \"HOME\", \"ADDR_LINE1\": \"653 STATE ROUTE 7\", \"ADDR_CITY\": \"FRESNO\", \"ADDR_STATE\": \"CA\", \"ADDR_POSTAL_CODE\": \"55073-1234\"}"
curl -X GET \
  --globoff \
  "${SENZING_DEMO_URL}/search-by-attributes/?q=${QUERY_STRING}"

# Delete record.

curl -X DELETE \
  ${SENZING_DEMO_URL}/delete-record/${SENZING_DEMO_DATASOURCE}/${RECORD_ID}

# Confirm record has been deleted.
# CAVEAT: Instead of returning an HTTP 404, an HTTP 500 is returned.

curl -X GET \
  ${SENZING_DEMO_URL}/get-record/${SENZING_DEMO_DATASOURCE}/${RECORD_ID} | jq .

MY_RECORD_ID="my-record-id"

curl -X POST \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data "{\"NAME_TYPE\": \"PRIMARY\", \"NAME_FIRST\": \"Bob\", \"NAME_LAST\": \"Jones\", \"ADDR_TYPE\": \"HOME\", \"ADDR_LINE1\": \"555 Bailey\", \"ADDR_CITY\": \"Washingtonville\", \"ADDR_STATE\": \"VA\", \"ADDR_POSTAL_CODE\": \"11123\"}" \
  ${SENZING_DEMO_URL}/add-record/${SENZING_DEMO_DATASOURCE}/${MY_RECORD_ID}

## Get the data from the record just created.

curl -X GET \
  ${SENZING_DEMO_URL}/get-record/${SENZING_DEMO_DATASOURCE}/${MY_RECORD_ID} | jq .

# Delete record.

curl -X DELETE \
  ${SENZING_DEMO_URL}/delete-record/${SENZING_DEMO_DATASOURCE}/${MY_RECORD_ID}
