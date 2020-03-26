#!/bin/sh
set -e

CONFIG_PATH=/data/options.json
MQTT_BROKER_URL=$(jq -r ".mqtt.broker_url" $CONFIG_PATH)
MQTT_TOPIC_PREFIX=$(jq -r ".mqtt.topic_prefix" $CONFIG_PATH)
MQTT_USERNAME=$(jq -r ".mqtt.username" $CONFIG_PATH)
MQTT_PASSWORD=$(jq -r ".mqtt.password" $CONFIG_PATH)

npm install

INSTANCES=$(jq '.devices | length' $CONFIG_PATH)

if [ "$INSTANCES" -gt 0 ]; then
	for i in $(seq 0 $(($INSTANCES - 1))); do
		MQTT_TOPIC_PREFIX=$(jq -r ".devices[$i].mqtt_topic_prefix" $CONFIG_PATH);
		if [[ $MQTT_TOPIC_PREFIX = null ]]; then echo "[ERROR] Missing mqtt_topic_prefix for device $i. Skipping." && continue; fi
		echo "Running instance $i for $HVAC_HOST"
		npx pm2 start index.js 02:e5:88:9a:cb:95 02:dc:bc:64:8c:06 --url mqtt://localhost
	done
	npx pm2 logs /HVAC_/
else
	echo "Running in single-instance mode (DEPRECATED)"
	node index.js \
		--mqtt-broker-url="${MQTT_BROKER_URL}" \
		--mqtt-topic-prefix="${MQTT_TOPIC_PREFIX}" \
		--mqtt-username="${MQTT_USERNAME}" \
		--mqtt-password="${MQTT_PASSWORD}"
fi
