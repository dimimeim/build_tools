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

. build/envsetup.sh
add_lunch_combo "liquid_$device-userdebug"
lunch "liquid_$device-userdebug"
time mka bootimage | tee build.log
