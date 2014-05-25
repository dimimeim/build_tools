repo init -u https://github.com/LiquidSmooth/android.git -b kitkat
repo forall -c 'git reset --hard ; git clean -fdx'

# Fix MediaProvider issues
sed -i 's/<project path="packages\/providers\/MediaProvider" name="packages_providers_MediaProvider" remote="sr" revision="kk4.4"  \/>/<project path="packages\/providers\/MediaProvider" name="luk1337\/android_packages_providers_MediaProvider" remote="gh" revision="master"  \/>/g' .repo/manifests/default.xml

# Sync repositories
repo sync -f

# Remove f2fs files from s2vep
sed -i '	\/device\/samsung\/s2vep\/ramdisk\/sbin\/automount:root\/sbin\/automount / d' device/samsung/s2vep/device_s2vep.mk
sed -i '	\/device\/samsung\/s2vep\/ramdisk\/sbin\/busybox:root\/sbin\/busybox / d' device/samsung/s2vep/device_s2vep.mk
sed -i '	\/device\/samsung\/s2vep\/ramdisk\/sbin\/sh:root\/sbin\/sh / d' device/samsung/s2vep/device_s2vep.mk

# Remove f2fs files from s2ve
sed -i '	\/device\/samsung\/s2ve\/ramdisk\/sbin\/automount:root\/sbin\/automount / d' device/samsung/s2ve/device_s2ve.mk
sed -i '	\/device\/samsung\/s2ve\/ramdisk\/sbin\/busybox:root\/sbin\/busybox / d' device/samsung/s2ve/device_s2ve.mk
sed -i '	\/device\/samsung\/s2ve\/ramdisk\/sbin\/sh:root\/sbin\/sh / d' device/samsung/s2ve/device_s2ve.mk

# Remove "\" from device.mk
sed -i 's/device\/samsung\/s2ve\/ramdisk\/fstab.capri_ss_s2ve:root\/fstab.capri_ss_s2vep \/device\/samsung\/s2ve\/ramdisk\/fstab.capri_ss_s2ve:root\/fstab.capri_ss_s2vep/g' device/samsung/s2ve/device_s2ve.mk
sed -i 's/device\/samsung\/s2vep\/ramdisk\/fstab.capri_ss_s2vep:root\/fstab.capri_ss_s2vep \/device\/samsung\/s2vep\/ramdisk\/fstab.capri_ss_s2vep:root\/fstab.capri_ss_s2vep/g' device/samsung/s2ve/device_s2ve.mk

# Fix ramdisk s2vep
sed -i 's/#\/dev\/block\/mmcblk0p19/\/dev\/block\/mmcblk0p19/g' device/samsung/s2vep/ramdisk/fstab.capri_ss_s2vep
sed -i 's/#\/dev\/block\/mmcblk0p18/\/dev\/block\/mmcblk0p18/g' device/samsung/s2vep/ramdisk/fstab.capri_ss_s2vep
sed -i 's/#\/dev\/block\/mmcblk0p21/\/dev\/block\/mmcblk0p21/g' device/samsung/s2vep/ramdisk/fstab.capri_ss_s2vep

# Fix ramdisk s2ve
sed -i 's/#\/dev\/block\/mmcblk0p19/\/dev\/block\/mmcblk0p19/g' device/samsung/s2ve/ramdisk/fstab.capri_ss_s2ve
sed -i 's/#\/dev\/block\/mmcblk0p18/\/dev\/block\/mmcblk0p18/g' device/samsung/s2ve/ramdisk/fstab.capri_ss_s2ve
sed -i 's/#\/dev\/block\/mmcblk0p21/\/dev\/block\/mmcblk0p21/g' device/samsung/s2ve/ramdisk/fstab.capri_ss_s2ve

# Remove automount
sed -i '    exec \/sbin\/automount/ d' device/samsung/s2vep/ramdisk/init.capri_ss_s2vep.rc
sed -i '    exec \/sbin\/automount/ d' device/samsung/s2ve/ramdisk/init.capri_ss_s2ve.rc

# Remove f2fs files
rm -rf device/samsung/s2vep/ramdisk/sbin
rm -rf device/samsung/s2ve/ramdisk/sbin
