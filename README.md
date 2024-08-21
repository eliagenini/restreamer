# Nginx Restreamer

This project provides a Docker image based on Ubuntu that sets up an Nginx server to restream a video stream from the internet using FFmpeg. The setup also includes a web player to view the restreamed content. Additionally, the project supports using a Gluetun container to connect the main restreaming container to a VPN when needed.

## Project Structure

- **Dockerfile**: Defines the Docker image, including installation of Nginx, FFmpeg, and necessary configurations.
- **nginx.conf**: Configuration file for Nginx, setting up the reverse proxy and stream handling.
- **entrypoint.sh**: Script that initializes the Nginx server and starts the restreaming process.
- **restream.sh**: Script that run ffmpeg to restream a given video stream
- **compose.yml**: Docker Compose file to orchestrate both the Nginx restreamer and the Gluetun VPN container.
- **index.html**: Contains the web player files to display the restream.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Usage

### 1. Clone the repository

```bash
git clone https://github.com/eliagenini/restreamer.git
cd restreamer
```

### 2. Build the Docker image
Build the Docker image using the provided **Dockerfile**:

```bash
docker build -t nginx-restreamer .
```

### 3. Run the Containers
To run the containers and start the restreaming server:

#### Without VPN

```bash
docker run -d -p 80:80 -e STREAM_URL=<your_stream_url> nginx-restreamer
```

#### With VPN
Use Docker Compose to run both the Gluetun VPN container and the restreamer container:
```bash
docker-compose up -d
```

Replace `<STREAM_URL>` in the .env file with the URL of the video stream you want to restream and add any details to configure Gluetun.

### 4. Access the Web Player
Open your browser and go to `http://<your_server_ip>` to view the restreamed content through the provided web player.

## Environment Variables

- **STREAM_URL**: The URL of the video stream to be restreamed.
- **VPN_SERVICE_PROVIDER**: VPN Service provider to use in gluetun (ex. protonvpn)
- **OPENVPN_USER**: In case of ProtonVPN, OpenVPN User
- **OPENVPN_PASS**: In case of ProtonVPN, OpenVPN Password
- **SERVER_COUNTRIES**: In case of ProtonVPN, Server countries