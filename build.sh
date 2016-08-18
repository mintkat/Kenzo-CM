# Paths
KERNEL=$PWD;
IMAGE=$KERNEL/arch/arm64/boot/Image;
DTB=$KERNEL/arch/arm64/boot/dt.img;
DTBTOOL=$KERNEL/dtbToolCM;
OUT=$KERNEL/out;
MODULES=$KERNEL/out/system/lib/modules;

# Toolchains
# UBERTC
	# TOOLCHAIN="/home/goghor/Android/TC/DespairFactor-aarch64-linux-android-4.9-kernel";
	# TC="UBERTC-4.9";
# Stock Google Toolchain
	TOOLCHAIN="/home/goghor/Android/TC/aarch64-linux-android-4.9-aosp";
	TC="GOOGLE-4.9";
STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip;
export CROSS_COMPILE=$TOOLCHAIN/bin/aarch64-linux-android-;
export LD_LIBRARY_PATH=$TOOLCHAIN/lib/;

# defconfig
KENZO_CM=cyanogenmod_kenzo_defconfig;

# Variables
THREADS=16;
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="MOVZX"
export KBUILD_BUILD_HOST="BlackMarch.net"
export LOCALVERSION="-Darkness™"

# Kernel Details
NAME="Kenzo_Darkness";
VERSION="-$(date +"%Y-%m-%d"-%H%M)-";
RELEASE="$NAME$VERSION$TC";

# Build Kernel
clear;
echo "665" > .version;
make $KENZO_CM -j$THREADS;
make Image -j$THREADS;
make dtbs -j$THREADS;
make modules -j$THREADS;
$DTBTOOL -2 -o $DTB -s 2048 -p $KERNEL/scripts/dtc/ $KERNEL/arch/arm/boot/dts/;
rm $MODULES/*;
find . -name '*.ko' -exec cp {} $MODULES/ \;
cd $MODULES;
$STRIP --strip-unneeded *.ko;
cd $OUT;
rm -rf *.zip;
rm -rf tools/Image;
rm -rf tools/dt.img;
mv $DTB $OUT/tools/dt.img;
mv $IMAGE $OUT/tools/Image;
cd $OUT;
zip -r `echo $RELEASE`.zip *;
pwd;
ll;
cd $KERNEL;
