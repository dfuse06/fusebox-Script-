#!/bin/sh 

CL_RED="\033[31m"

echo "About to make this mother fucking fusebox!!!!!";

secs=$((5 * 1))
while [ $secs -gt 0 ]; do
   echo -ne "$secs\033[0K\r"
   sleep 0.5
   : $((secs--))
done

echo -e ${CL_RED}"Fusebox kernel initiating${CL_RED}";

cd ~/fusebox/
make clean && make mrproper
export CROSS_COMPILE=~/ndk/toolchains/arm-eabi-5.3/bin/arm-eabi-
make fusebox_defconfig ARCH=arm
make -j8 ARCH=arm
