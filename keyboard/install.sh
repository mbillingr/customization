
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo patch -d/ -p0 -N -r- -i $SCRIPT_DIR/us.patch
sudo python $SCRIPT_DIR/patch_evdev.py

# delete xkb cache
rm /var/lib/xkb/*.xkm

