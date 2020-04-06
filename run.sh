#!/bin/sh
set -e

CONFIG_PATH=/data/options.json
MQTT_BROKER_URL=$(jq -r ".mqtt.broker_url" $CONFIG_PATH)
MQTT_TOPIC_PREFIX=$(jq -r ".mqtt.topic_prefix" $CONFIG_PATH)
MQTT_USERNAME=$(jq -r ".mqtt.username" $CONFIG_PATH)
MQTT_PASSWORD=$(jq -r ".mqtt.password" $CONFIG_PATH)

npm install -g https://github.com/BasDV/am43-ctrl
node index.js $(jq -r ".blinds_macs" $CONFIG_PATH) --url $MQTT_BROKER_URL