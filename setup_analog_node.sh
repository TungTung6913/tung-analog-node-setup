#!/bin/bash

# Check if a node name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <node_name>"
  exit 1
fi

NODE_NAME=$1

# Update Source
sudo apt update && sudo apt upgrade -y

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "Docker not found, installing..."
  # Install Docker
  sudo apt install -y git apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce
  sudo systemctl start docker
  sudo systemctl enable docker
else
  echo "Docker is already installed."
fi

# Check if websocat is installed
if ! command -v websocat &> /dev/null; then
  echo "websocat not found, installing..."
  # Install websocat
  sudo wget -qO /usr/local/bin/websocat https://github.com/vi/websocat/releases/download/v1.13.0/websocat.x86_64-unknown-linux-musl
  sudo chmod a+x /usr/local/bin/websocat
else
  echo "websocat is already installed."
fi

# Verify websocat installation
websocat --version

# Pull and run Analog node
docker pull analoglabs/timechain
docker run -d -p 9944:9944 -p 30403:30303 analoglabs/timechain --base-path /data --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external --name "$NODE_NAME"

# Create session key and capture the output
SESSION_KEY=$(echo '{"id":1,"jsonrpc":"2.0","method":"author_rotateKeys","params":[]}' | websocat -n1 -B 99999999 ws://127.0.0.1:9944)

echo "Session key created: $SESSION_KEY"
echo "Analog node setup is complete."

