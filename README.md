# Analog Node Setup Script

This repository contains a script to easily set up an Analog node. The script checks for and installs necessary dependencies like Docker and websocat if they are not already installed. If these dependencies are already present, the script will skip their installation and proceed directly to setting up the Analog node.

## Prerequisites

Before running the script, make sure you have `git` installed. This is necessary to clone the repository.

### Install Git

If `git` is not already installed, you can install it using:

```bash
sudo apt install git
```


### Clone the Repository
First, clone the repository to your local machine:
```bash
git clone https://github.com/tungtung6913/tung-analog-node-setup.git
```


Navigate to the repository directory:
```bash
cd tung-analog-node-setup
```


### Make the Script Executable
Make the script executable by running:
```bash
chmod +x setup_analog_node.sh
```


### Run the Script To Start Node Installation
Run the script with your desired node name (Change <node_name> with you prefered name):
```bash
./setup_analog_node.sh <node_name>
```
You will see your `SESSION KEY` in the end. Please save it for register node at `https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc.testnet.analog.one#/staking/actions`. Then, Click `+ Validator` and Adjust The commission and Add `Your SESSION KEY` There.



# Now' Your Installation Is Complete



### Check The Log
```bash
docker logs <docker id>



