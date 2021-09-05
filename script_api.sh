#!/bin/sh

set -e
# Create a service
echo "Create a service \n\n"

curl --location --request POST 'http://localhost:8001/services' \
--header 'Content-Type: application/json' \
--data-raw '{
    "host": "host.docker.internal",
    "connect_timeout": 60000,
    "protocol": "http",
    "name": "mock-api",
    "port": 9999
}'

echo "Create Route Associated with service \n\n"
curl --location --request POST 'http://localhost:8001/services/mock-api/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
	"name": "mock-api-route",
    "strip_path": false,
    "paths": ["/api"]
}'

echo "Enable with custom plugin \n\n"
curl --location --request POST 'http://localhost:8001/services/mock-api/plugins' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "custom-plugin",
    "config": {"msg": "this config via api"},
    "protocols": ["http"],
    "enabled": true
}'
