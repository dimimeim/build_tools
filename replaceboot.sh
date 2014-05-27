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

echo 'run_program("/sbin/mount", "-t", "auto", "/dev/block/mmcblk0p19", "/system"); ' >> META-INF/com/google/android/updater-script
echo 'package_extract_dir("system", "/system");' >> META-INF/com/google/android/updater-script
echo 'set_perm_recursive(0, 0, 0755, 0755, "/system/etc/init.d");' >> META-INF/com/google/android/updater-script
echo 'unmount("/system");' >> META-INF/com/google/android/updater-script
echo 'package_extract_dir("kernel", "/tmp");' >> META-INF/com/google/android/updater-script
echo 'set_perm(0, 0, 0777, "/tmp/dd");' >> META-INF/com/google/android/updater-script
echo 'set_perm(0, 0, 0777, "/tmp/mkbootimg.sh");' >> META-INF/com/google/android/updater-script
echo 'set_perm(0, 0, 0777, "/tmp/mkbootimg");' >> META-INF/com/google/android/updater-script
echo 'set_perm(0, 0, 0777, "/tmp/unpackbootimg");' >> META-INF/com/google/android/updater-script
echo 'run_program("/tmp/dd", "if=/dev/block/mmcblk0p5", "of=/tmp/boot.img");' >> META-INF/com/google/android/updater-script
echo 'run_program("/tmp/unpackbootimg", "-i", "/tmp/boot.img", "-o", "/tmp/");' >> META-INF/com/google/android/updater-script
echo 'run_program("/tmp/mkbootimg.sh");' >> META-INF/com/google/android/updater-script
echo 'run_program("/tmp/dd", "if=/tmp/newboot.img", "of=/dev/block/mmcblk0p5");' >> META-INF/com/google/android/updater-script

zip -r "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" META-INF
zip -r "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" kernel
zip -r "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" system

md5sum "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip" > "../out/target/product/$device/LS-KK-v3.1-$(date +%Y-%m-%d)-$device.zip.md5sum"
rm -rf META-INF
