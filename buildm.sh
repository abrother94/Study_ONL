#!/bin/bash
cd OpenNetworkLinux
apt-cacher-ng
source setup.env
echo "##### onlp build ####"
echo ""
make -C /home/nick_huang/Study_ONL/OpenNetworkLinux/packages/base/amd64/onlp/builds  -j16
echo ""
echo "##### kernel build ####"
echo ""
make -C /home/nick_huang/Study_ONL/OpenNetworkLinux/packages/base/amd64/kernels/kernel-3.16-lts-x86-64-all/builds  -j16
echo ""
echo "##### accton modules build ####"
echo ""
make -C /home/nick_huang/Study_ONL/OpenNetworkLinux/packages/platforms/accton/x86-64/x86-64-accton-as5812-54t/modules/builds
echo ""
echo "##### modules build ####"
echo ""
make -C /home/nick_huang/Study_ONL/OpenNetworkLinux/packages/platforms/accton/x86-64/modules/builds  -j16
echo ""


