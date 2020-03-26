#!/bin/sh
set -e

CONFIG_PATH=/data/options.json
MQTT_BROKER_URL=$(jq -r ".mqtt.broker_url" $CONFIG_PATH)
MQTT_TOPIC_PREFIX=$(jq -r ".mqtt.topic_prefix" $CONFIG_PATH)
MQTT_USERNAME=$(jq -r ".mqtt.username" $CONFIG_PATH)
MQTT_PASSWORD=$(jq -r ".mqtt.password" $CONFIG_PATH)

npm install
node index.js 02:e5:88:9a:cb:95 02:dc:bc:64:8c:06 --url $MQTT_BROKER_URL
