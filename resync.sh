repo init -u https://github.com/LiquidSmooth/android.git -b kitkat
repo forall -c 'git reset --hard ; git clean -fdx'

# Sync repositories
repo sync -f
