# HydroGrow: Automated Soilless Vertical Garden

HydroGrow is an automated system for maintaining a soilless vertical garden. Using an ESP8266 microcontroller, HydroGrow automates the task of watering plants, and monitors the water level and mineral content in real-time. The system also provides remote monitoring through MQTT messaging protocol, allowing the data to be observed in a user-friendly interface provided by Home Assistant.

## Hardware Requirements

1. ESP8266 Development Board (NodeMCU)
2. Water Pump
3. Water Level Sensor
4. EC/TDS Sensor or pH Sensor (For water mineral level readings)
5. Relay Module (for pump control)
6. Breadboard and Jumper Wires
7. Power Supply suitable for your pump and ESP8266
8. Waterproof Enclosure
9. Basic components like resistors, capacitors if necessary

## Software Requirements

1. MicroPython's firmware for ESP8266.
2. MQTT Broker (Mosquitto or any other).
3. Home Assistant Server

## Setup Instructions

1. Setup your hardware as per your garden's requirement.
2. Flash the MicroPython firmware onto the ESP8266.
3. Adjust the pin settings in the MicroPython script according to your hardware setup.
4. Update your WiFi and MQTT broker details in the script.
5. Run the script on ESP8266.
6. The system should now be reading sensor data, controlling the pump, and publishing sensor data to your MQTT broker.
7. Configure Home Assistant to subscribe to your MQTT topics to get live updates from your garden.

## Functionality

HydroGrow works by continuously monitoring the water level and mineral content of the water in your vertical garden system. If the water level gets too low, it automatically triggers a pump to refill the system. All the readings are sent to a Home Assistant server using MQTT, which allows for easy and remote monitoring.

## License

MIT License

## Author

Zach Robichaud (zach2825)
