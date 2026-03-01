![Hyperion](https://github.com/hyperion-project/hyperion.ng/blob/master/doc/logo_dark.png?raw=true#gh-dark-mode-only)
![Hyperion](https://github.com/hyperion-project/hyperion.ng/blob/master/doc/logo_light.png?raw=true#gh-light-mode-only)

# hyperionng-docker-container

## NOTE
Default password = Password123
Don't forget to edit '/boot/firmware/config.txt' and uncomment the 'dtparam=spi=on' line, then reboot, to enable GPIO pins on a Raspberry Pi 4

## About
This repo contains a dockerfile and Docker Compose file to build and run [hyperion.ng](https://github.com/hyperion-project/hyperion.ng), primarily with the aim of using a Raspberry Pi 4's GPIO pins to connect to APA102, or similar, LED strips.

Inspiration has been taken from both [psychowood](https://github.com/psychowood/hyperion.ng-docker) and [foorschtbar](https://github.com/foorschtbar/hyperion-docker) repos. Credit to both for the starting point, but for a few reasons I changed their code for my own use, so am sharing it here in case it's useful for anyone else.

## Usage

git clone the repo
```sh
git clone https://github.com/mpsamuels/hyperionng-docker-container.git
```
docker build the local image
```sh
docker build -t hyperionng .
```
if you want to run a nightly hyperionng build, add --build-arg RELEASE_TYPE=nightly i.e
```sh
docker build -t hyperionng --build-arg RELEASE_TYPE=nightly .
```
start the container with
```sh
docker compose up -d
```

## Further Configuration

### Device mapping
As above, this is intended for my own use and specifically maps a Raspberry Pi 4's GPIO pins to the running container. If you want to use any other device, check lines 8-12 on the compose.yaml file for inspiration on the devices you may want to pass through to the container. Alternatively, refer to your device's documentation or HyperionNG's support forums.

### Default Password
Once started the Hyperion UI is available at port 8090 of the host device. The UI's default password is 'Password123'. A database with no configuration other than a default password is included in the repo to ensure that the UI is accessible on first run when using port mappings. Otherwise, security restrictions within the HyperionNG software prevent the UI from being accessible from a different subnet, i.e any standard LAN address outside of the Docker host network, while no password is set.

### Networking
Should you wish to give the container a specific IP address within your own LAN, rather than bridge across the Docker host network, see line 23 and below of the compose.yaml file.

### Volume mapping
By default a ./data sub-folder is created on the Docker host to persist data between runs. See line 14 of the compose.yaml if you'd prefer to store persistent data elsewhere.

### Versions
With exception of when using the RELEASE_TYPE build argument, the dockerfile will always use the latest stable version of Debian Trixie and HyperionNG when building.