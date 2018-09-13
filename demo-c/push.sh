#!/bin/bash
set -e

./mvnw clean package -DskipTests=true && cf push

cf add-network-policy demo-b --destination-app demo-c --protocol tcp --port 8080