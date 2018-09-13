#!/bin/bash
set -e

./mvnw clean package -DskipTests=true && cf push

cf add-network-policy demo-a --destination-app demo-b --protocol tcp --port 8080