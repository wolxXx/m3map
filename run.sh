#!/bin/bash

set -e
set -x

HERE=$(dirname $(readlink -f "$0"));
cd "$HERE";

source .env


required_vars=("WEB_PORT")
missing_vars=()

for var_name in "${required_vars[@]}"; do
    if [ -z "${!var_name}" ]; then
        missing_vars+=("$var_name")
    fi
done

if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "Error: The following variables are not set in .env file: ${missing_vars[*]}"
    exit 1
fi

VERSION="1.3"

docker build -t wolxxx/m3map:$VERSION .

set +e
docker stop m3map
docker rm m3map
set -e

docker run -it --restart=always --name m3map -d -p 127.0.0.1:$WEB_PORT:80 wolxxx/m3map:$VERSION

echo "running under http://localhost:$WEB_PORT"