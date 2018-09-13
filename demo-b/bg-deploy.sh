#!/bin/bash
set -e
APP_NAME=demo-b

./mvnw clean package -DskipTests=true
set +e
cf rename ${APP_NAME} ${APP_NAME}-venerable
set -e
mv target/*.jar target/${APP_NAME}.jar
cf push -p target/${APP_NAME}.jar -f manifest.yml
cat manifest.yml | ruby -ryaml -e 'app = YAML.load(ARGF)["applications"][0]; app["network_policies"].each { |x| if x["source"] == nil then puts "cf add-network-policy " + app["name"] + " --destination-app " + x["destination"] + " --protocol " + x["protocol"] + " --port " + x["port"].to_s else puts "cf add-network-policy " + x["source"] + " --destination-app " + app["name"] +  + " --protocol " + x["protocol"] + " --port " + x["port"].to_s end }' > add-network-policies.sh
bash add-network-policies.sh
INTERNAL_HOST_NAME=$(grep apps.internal manifest.yml | grep -v http  | sed 's/  - route: //g' | sed 's/.apps.internal//g')
cf unmap-route ${APP_NAME}-venerable apps.internal --hostname ${INTERNAL_HOST_NAME}
cf delete ${APP_NAME}-venerable -f
rm -f add-network-policies.sh