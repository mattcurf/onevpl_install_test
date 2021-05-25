#!/bin/bash

#
# Installs General Purpose GPU Drivers and oneVPL development kit for Linux
# 
# See https://dgpu-docs.intel.com/installation-guides/index.html and
# https://software.intel.com/content/www/us/en/develop/articles/oneapi-repo-instructions.html
#

if [ -f /etc/os-release ]; then
  export DISTRO_NAME=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
  export DISTRO_VER=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
fi

cd /tmp
echo $DISTRO_NAME $DISTRO_VER
case "$DISTRO_NAME $DISTRO_VER" in

## Ubuntu
  "ubuntu 20.04")
    wget -qO - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | apt-key add - 
    wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | apt-key add - 
    sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main"
    sudo add-apt-repository "deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main"
    sudo apt-get update
    sudo apt-get install -y intel-opencl-icd intel-media-va-driver-non-free libmfx1 intel-oneapi-onevpl-devel
    ;;

## Centos8 
  "centos 8")
    sudo dnf install -y 'dnf-command(config-manager)'
    sudo dnf config-manager --add-repo https://repositories.intel.com/graphics/rhel/8.2/intel-graphics.repo

    tee > /tmp/oneAPI.repo << EOF
[oneAPI]
name=Intel(R) oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF
    sudo mv /tmp/oneAPI.repo /etc/yum.repos.d
    sudo dnf update -y --refresh
    sudo dnf install -y intel-opencl intel-media intel-mediasdk intel-oneapi-onevpl-devel 
    ;;

## SuSE
  "opensuse-leap 15.2")
    sudo zypper addrepo -G -f -r https://repositories.intel.com/graphics/sles/15sp2/intel-graphics.repo
    sudo zypper addrepo -G -f https://yum.repos.intel.com/oneapi oneAPI
    sudo zypper --non-interactive install intel-opencl intel-media-driver libmfx1 intel-oneapi-onevpl-devel
    ;;

  *)
    echo -n "Unsupported distribution, please see documentation for other driver installation options"
    ;;
esac
