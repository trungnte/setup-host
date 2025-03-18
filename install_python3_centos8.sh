#!/bin/bash

# Script to install Python 3.19 from source on CentOS 8

# Variables
PYTHON_VERSION="3.13.2" # Adjust if a different version is released
PYTHON_TARBALL="Python-${PYTHON_VERSION}.tgz"
PYTHON_URL="https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_TARBALL}"
INSTALL_PREFIX="/usr/local" # Where to install Python
NUM_JOBS=$(nproc) # Number of CPU cores for faster compilation

# Update system and install necessary dependencies
echo "Updating system and installing dependencies..."
yum update -y
yum install -y wget tar gcc make zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel xz-devel

# Download Python source code
echo "Downloading Python ${PYTHON_VERSION} source..."
wget "${PYTHON_URL}"

# Extract the tarball
echo "Extracting the tarball..."
tar xzf "${PYTHON_TARBALL}"

# Change directory to the extracted source
cd "Python-${PYTHON_VERSION}"

# Configure, make, and install Python
echo "Configuring, making, and installing Python..."
./configure --enable-optimizations --prefix="${INSTALL_PREFIX}"
make -j "${NUM_JOBS}"
sudo make altinstall # Use altinstall to avoid replacing system Python

# Clean up
echo "Cleaning up..."
cd ..
rm -rf "Python-${PYTHON_VERSION}" "${PYTHON_TARBALL}"

# Verify installation
echo "Verifying installation..."
"${INSTALL_PREFIX}/bin/python3.13" --version

echo "Python ${PYTHON_VERSION} installed successfully in ${INSTALL_PREFIX}."

#Add to path (optional, but recommended)
echo "Adding Python to path for current user."
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

echo "Python 3.13 added to path."

#Verify path addition.
python3.13 --version


echo "Set the new Python3.19 executable as default"
alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.13 1 && alternatives --set python3 /usr/local/bin/python3.13 && echo "2" | alternatives --config python

exit 0
