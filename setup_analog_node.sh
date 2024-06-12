#!/bin/bash

# Update Source
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y git apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker

# Install websocat
sudo wget -qO /usr/local/bin/websocat https://github.com/vi/websocat/releases/download/v1.13.0/websocat.x86_64-unknown-linux-musl
sudo chmod a+x /usr/local/bin/websocat

# Verify websocat installation
websocat --version

# Pull and run Analog node
docker pull analoglabs/timechain
docker run -d -p 9944:9944 -p 30403:30303 analoglabs/timechain --base-path /data --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external --name yourname

# Create session key
echo '{"id":1,"jsonrpc":"2.0","method":"author_rotateKeys","params":[]}' | websocat -n1 -B 99999999 ws://127.0.0.1:9944

echo "Analog node setup is complete."

