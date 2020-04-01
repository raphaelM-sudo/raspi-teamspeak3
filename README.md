# Raspi-Teamspeak3
Dockerized Teamspeak 3 server for Raspberry Pi 1, 2, 3 and 4 using ExaGear.

## Usage
Simply run the easy-install.sh script which will create the correct ExaGear image according to your Raspberry Pi version and a Teamspeak 3 server on top of it:
(Docker Compose is required)
```
./easy-install.sh <PI_VERSION> <TS3_VERSION>
```

## Configuration
The configuration works in the same way as in the official [docker image](https://hub.docker.com/_/teamspeak)
