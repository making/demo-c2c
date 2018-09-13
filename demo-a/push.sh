#!/bin/bash
set -e

./mvnw clean package -DskipTests=true && cf push