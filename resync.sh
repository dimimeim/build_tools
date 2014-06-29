repo init -u https://github.com/Cyanogenmod/android.git
repo forall -c 'git reset --hard ; git clean -fdx'

# Sync repositories
repo sync -f
vendor/cm/get-prebuilts