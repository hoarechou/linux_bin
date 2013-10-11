#!/bin/bash

if [ "$1" == "" ]; then
	echo "usage: imgs_dl.sh [all|moderm|android] path"
	exit 0
fi
if [ "$2" != "" ]; then
	path=$2
else
	path="~/imgs"
fi

echo "imgs'path is in $path"

adb reboot bootloader
sleep 5

case $1 in

	all)
	echo ""
	fastboot flash partition $path/gpt_both0.bin
	fastboot flash aboot $path/emmc_appsboot.mbn
	fastboot flash boot $path/boot.img
	fastboot flash sbl1 $path/sbl1.mbn
	fastboot flash sbl2	$path/sbl2.mbn
	fastboot flash sbl3	$path/sbl3.mbn
	fastboot flash rpm $path/rpm.mbn
	fastboot flash tz $path/tz.mbn
	fastboot flash modem $path/NON-HLOS.bin
	fastboot flash recovery $path/recovery.img
	fastboot flash system $path/system.img
	fastboot flash userdata $path/userdata.img
	fastboot flash persist $path/persist.img
	fastboot flash cache $path/cache.img
	;;
	moderm)
	fastboot flash sbl1 $path/sbl1.mbn
	fastboot flash sbl2	$path/sbl2.mbn
	fastboot flash sbl3	$path/sbl3.mbn
	fastboot flash rpm $path/rpm.mbn
	fastboot flash tz $path/tz.mbn
	fastboot flash modem $path/NON-HLOS.bin
	;;
	android)
	fastboot flash boot $path/boot.img
	fastboot flash recovery $path/recovery.img
	fastboot flash system $path/system.img
	fastboot flash userdata $path/userdata.img
	fastboot flash persist $path/persist.img
	;;
	system)
	fastboot flash system $path/system.img
	;;
	boot)
	fastboot flash boot $path/boot.img
	;;
esac
fastboot reboot

