repo init -u https://github.com/LiquidSmooth/android.git -b kitkat
repo forall -c 'git reset --hard ; git clean -fdx'

# Fix MediaProvider issues
sed -i 's/<project path="packages\/providers\/MediaProvider" name="packages_providers_MediaProvider" remote="sr" revision="kk4.4"  \/>/<project path="packages\/providers\/MediaProvider" name="luk1337\/android_packages_providers_MediaProvider" remote="gh" revision="master"  \/>/g' .repo/manifests/default.xml

# Sync repositories
repo sync -f