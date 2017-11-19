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

cd ~/lazy/lazy/
rm -fr zImage-dtb
rm -fr kernel-flasher-5.1-*
rm -fr modules/*

cp ~/fusebox/crypto/ansi_cprng.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/char/rdbg.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/input/evbug.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/media/usb/gspca/gspca_main.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/mmc/card/mmc_test.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/spi/spidev.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/usb/gadget/legacy/g_laf.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/video/backlight/backlight.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/video/backlight/lcd.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/video/backlight/generic_bl.ko ~/lazy/lazy/modules/
cp ~/fusebox/drivers/usb/gadget/udc/dummy_hcd.ko ~/lazy/lazy/modules/
cp ~/fusebox/arch/arm/boot/zImage-dtb ~/lazy/lazy/

echo "Make this zip, BITCH!"

make 

cd ~/

echo "Done mother fucker!" 
sleep 5

#exit 