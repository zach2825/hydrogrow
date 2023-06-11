import machine
import time
from umqtt.simple import MQTTClient
import network

# WiFi settings
ssid = 'your_SSID'
password = 'your_password'

# MQTT settings
mqtt_server = 'your_mqtt_server'
topic_pub = 'your_topic_pub'

# Sensor settings
water_level_pin = machine.ADC(0)  # Assuming water level sensor is on A0
mineral_level_pin = machine.ADC(2)  # Assuming mineral level sensor is on A2
pump_relay_pin = machine.Pin(5, machine.Pin.OUT)  # Assuming relay is on D1

# Connect to WiFi
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)

while not wlan.isconnected():
    time.sleep(1)

print('WiFi connected')

# Connect to MQTT Server
client = MQTTClient("umqtt_client", mqtt_server)
client.connect()

print('MQTT connected')


# Publish sensor data
def publish_sensor_data():
    water_level: object = water_level_pin.read()
    mineral_level = mineral_level_pin.read()
    data = {'water_level': water_level, 'mineral_level': mineral_level}
    client.publish(topic_pub, str(data))


# Control the water pump
def control_pump(state):
    pump_relay_pin.value(state)


while True:
    try:
        publish_sensor_data()
        water_level = water_level_pin.read()

        # Simple logic: turn on pump if water level is low, turn off if high
        if water_level < 500:
            control_pump(1)
        elif water_level > 800:
            control_pump(0)

        time.sleep(1)
    except OSError as e:
        pass
