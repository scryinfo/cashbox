
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

bash $batPath/build_aarch64-linux-android.sh
bash $batPath/build_x86_64-linux-android.sh
bash $batPath/build_i686-linux-android.sh
bash $batPath/build_armv7-linux-androideabi.sh

#bash $batPath/build_x86_64-pc-windows-gnu.sh

cd $cuPath