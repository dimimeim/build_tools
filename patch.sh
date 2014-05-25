echo "otaupdater.otaid=luk1337_ls" >> device/samsung/s2vep/system.prop
echo "otaupdater.otaid=luk1337_ls" >> device/samsung/s2ve/system.prop
echo "otaupdater.otaid=luk1337_ls" >> device/htc/pyramid/system.prop

if [ "$1" = "s2vep" ] || [ "$1" = "s2ve" ]; then
	patch -p0 < 1.patch
	patch -p0 < 2.patch
	patch -p0 < 3.patch
	patch -p0 < 4.patch
	patch -p0 < 5.patch
fi

