#!/bin/bash

# Version of installSynApps to setup
INSTALL_SYNAPPS_VERSION=R2-4

# Install-Configuration version
CONFIG_VERSION=R3-8

# Init IOC version
INIT_IOC_VERSION=v0.0.5

# Config to use. Deb 9 gives decent coverage
CONFIG=configureDeb9

echo "Setting up EPICS directory, owned by user $1..."

cd /
sudo mkdir epics
sudo chown $1:$1 epics

echo "Creating EPICS helper directories..."
cd epics
mkdir utils
mkdir src
mkdir iocs
mkdir prod
mkdir dev
mkdir css

echo "Grabbing selected release of installSynApps: $INSTALL_SYNAPPS_VERSION..."
cd utils
wget https://github.com/jwlodek/installSynApps/archive/$INSTALL_SYNAPPS_VERSION.tar.gz
tar -xzf $INSTALL_SYNAPPS_VERSION.tar.gz
rm *.tar.gz
mv installSynApps-$INSTALL_SYNAPPS_VERSION installSynApps

echo "Grabbing selected version of config files: $CONFIG_VERSION..."
wget https://github.com/epicsNSLS2-deploy/Install-Configurations/archive/$CONFIG_VERSION.tar.gz
tar -xzf $CONFIG_VERSION.tar.gz
rm *.tar.gz

echo "Building EPICS using config: $CONFIG..."
cd installSynApps
python3 -u installCLI.py -i /epics/src -c ../Install-Configurations-$CONFIG_VERSION/$CONFIG -y -p

echo "Grabbing initIOC version: $INIT_IOC_VERSION..."
cd ..
wget https://github.com/epicsNSLS2-deploy/initIOC/archive/$INIT_IOC_VERSION.tar.gz
tar -xzf $INIT_IOC_VERSION.tar.gz


