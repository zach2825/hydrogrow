# HydroGrow: Automated Soilless Vertical Garden

HydroGrow is an automated system for maintaining a soilless vertical garden. Using an ESP8266 microcontroller, HydroGrow
automates the task of watering plants, and monitors the water level and mineral content in real-time. The system also
provides remote monitoring through MQTT messaging protocol, allowing the data to be observed in a user-friendly
interface provided by Home Assistant.

## Hardware Needed

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

1. Copy config.py.example to config.py and update the values in config.py with your own.
2. Setup your hardware as per your garden's requirement.
3. Flash the MicroPython firmware onto the ESP8266.
4. Adjust the pin settings in the MicroPython script according to your hardware setup.
5. Update your WiFi and MQTT broker details in the script.
6. Run the script on ESP8266.
7. The system should now be reading sensor data, controlling the pump, and publishing sensor data to your MQTT broker.
8. Configure Home Assistant to subscribe to your MQTT topics to get live updates from your garden.

# Programming the ESP8266

To upload new code to the ESP8266, it needs to be in the "programming mode". Here are the steps to put the ESP8266 into
programming mode:

1. **Disconnect power:** Start by disconnecting the ESP8266's power supply to ensure it's turned off.
2. **Set GPIO0 to LOW:** Press and hold flash button.
3. **Connect power:** 
   1. While keeping the flash button pressed, reconnect the power to the ESP8266. 
   2. or **connect GPIO0 to GND** using a jumper wire.
4. **Connect power:** While keeping GPIO0 connected to GND, reconnect the power to the ESP8266.

The ESP8266 should now be in programming mode, and you can upload your new code. After you've uploaded your code, you
can disconnect GPIO0 from GND and reset the board to start running your new program.

**Note:** The exact process can vary depending on your specific ESP8266 module or development board. Some boards have
buttons that put the board into programming mode when pressed. Consult your board's documentation for specific
instructions.

## Functionality

HydroGrow works by continuously monitoring the water level and mineral content of the water in your vertical garden
system. If the water level gets too low, it automatically triggers a pump to refill the system. All the readings are
sent to a Home Assistant server using MQTT, which allows for easy and remote monitoring.

## TIPS

get where the device is connected in the /dev directory 
    
```bash
yarn device:detect-linux
```

that will output something like this

```bash
/dev/ttyUSB0
```

You just use ttyUSB0 as the device in the other commands

## Useful links

* https://randomnerdtutorials.com/esp8266-pinout-reference-gpios/
* https://micropython-stubs.readthedocs.io/en/latest/firmware_grp.html

## Esp8266 pinout

keep in mind that the pinout is different for each board,
so you need to check the pinout for your specific board and for like the A0 pin you'd need to use ADC(0)
or a D0 you'd need to use GPIO(16)

Table from here - https://randomnerdtutorials.com/esp8266-pinout-reference-gpios/****

| Label | GPIO   | Input         | Output                | Notes                                                             |
|-------|--------|---------------|-----------------------|-------------------------------------------------------------------|
| D0    | GPIO16 | no interrupt  | no PWM or I2C support | HIGH at boot, used to wake up from deep sleep                     |
| D1    | GPIO5  | OK            | OK                    | often used as SCL (I2C)                                           |
| D2    | GPIO4  | OK            | OK                    | often used as SDA (I2C)                                           |
| D3    | GPIO0  | pulled up     | OK                    | connected to FLASH button, boot fails if pulled LOW               |
| D4    | GPIO2  | pulled up     | OK                    | HIGH at boot, connected to on-board LED, boot fails if pulled LOW |
| D5    | GPIO14 | OK            | OK                    | SPI (SCLK)                                                        |
| D6    | GPIO12 | OK            | OK                    | SPI (MISO)                                                        |
| D7    | GPIO13 | OK            | OK                    | SPI (MOSI)                                                        |
| D8    | GPIO15 | pulled to GND | OK                    | SPI (CS), Boot fails if pulled HIGH                               |
| RX    | GPIO3  | OK            | RX pin                | HIGH at boot                                                      |
| TX    | GPIO1  | TX pin        | OK                    | HIGH at boot, debug output at boot, boot fails if pulled LOW      |
| A0    | ADC0   | Analog Input  | X                     |                                                                   |


## License

MIT License

## Author

Zach Robichaud (zach2825)
