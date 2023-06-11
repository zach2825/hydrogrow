import time
from umqtt.simple import MQTTClient
import network
import config

# Connect to WiFi
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(config.ssid, config.password)

while not wlan.isconnected():
    time.sleep(1)

print('WiFi connected')
print('Device IP:', wlan.ifconfig()[0])

# Connect to MQTT Server
client = MQTTClient("umqtt_client", config.mqtt_server, config.mqtt_port)
client.connect()

print('MQTT connected')


def announce_to_home_assistant():
    # Device information
    device_info = {
        "identifiers": ["vertical_garden"],
        "name": "Vertical Garden",
        "model": "ESP8266",
        "manufacturer": "Espressif"
    }

    # Sensor information
    sensor_info = {
        "device": device_info,
        "name": "Water Level",
        "state_topic": "{}/state".format(config.topic_pub),
        "unit_of_measurement": "cm",
        "value_template": "{{ value_json.water_level }}"
    }

    # Publish discovery message
    client.publish("{}/sensor/{}/config".format(config.homeassistant_discovery_prefix, device_info["identifiers"][0]), str(sensor_info), retain=True)


# Publish sensor data
def publish_sensor_data():
    # noinspection PyShadowingNames
    water_level: object = config.water_level_pin.read()
    data = {'water_level': water_level}
    client.publish(config.topic_pub, str(data))


# Control the water pump
def control_pump(state):
    config.pump_relay_pin.value(state)


while True:
    try:
        publish_sensor_data()
        water_level = config.water_level_pin.read()

        # Simple logic: turn on pump if water level is low, turn off if high
        if water_level < 500:
            control_pump(1)
        elif water_level > 800:
            control_pump(0)

        time.sleep(1)
    except OSError as e:
        pass
