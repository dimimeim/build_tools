export USE_CCACHE=1
continue=0

while [ $continue -eq "0" ]; do
	echo "Select device: s2vep, s2ve, pyramid"
	read device
	if [ "$device" = "s2vep" ] || [ "$device" = "s2ve" ] || [ "$device" = "pyramid" ]; then 
		continue=1
	else
		echo "Wrong input!"
	fi
done

cd boots_f2fs
zip -r "../out/device/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" "boot_$device.img"
zip -d "../out/device/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" boot.img
printf "@ boot_$device.img\n@=boot.img\n" | zipnote -w "../out/device/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip"
md5sum "../out/device/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" > "../out/device/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip.md5sum"
