export USE_CCACHE=1
continue=0

while [ $continue -eq "0" ]; do
	echo "Select device: s2vep, s2ve"
	read device
	if [ "$device" = "s2vep" ] || [ "$device" = "s2ve" ] || [ "$device" = "pyramid" ]; then 
		continue=1
	else
		echo "Wrong input!"
	fi
done

cd boots_f2fs
zip -r "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" "boot_$device.img"
zip -d "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" boot.img
printf "@ boot_$device.img\n@=boot.img\n" | zipnote -w "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip"

unzip "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" "META-INF/*"
sed -i 's/mount("ext4", "EMMC", "\/dev\/block\/mmcblk0p19", "\/system");/run_program("\/sbin\/mount", "-t", "auto", "\/dev\/block\/mmcblk0p19", "\/system");/g' META-INF/com/google/android/updater-script
sed -i '/format("ext4", "EMMC", "\/dev\/block\/mmcblk0p19", "0", "\/system");/ d' META-INF/com/google/android/updater-script
zip -r "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" META-INF

md5sum "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" > "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip.md5sum"
rm -rf META-INF
