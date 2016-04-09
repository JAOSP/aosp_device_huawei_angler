#!/bin/sh

VENDOR=huawei
DEVICE=angler

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/angler-mhc19q-factory-f5a4e7a1.tgz
tar zxf angler-mhc19q-factory-f5a4e7a1.tgz
rm angler-mhc19q-factory-f5a4e7a1.tgz
cd angler-mhc19q
unzip image-angler-mhc19q.zip
rm image-angler-mhc19q.zip
cd ../
./simg2img angler-mhc19q/vendor.img vendor.ext4.img
mkdir vendor
sudo mount -o loop -t ext4 vendor.ext4.img vendor
./simg2img angler-mhc19q/system.img system.ext4.img
mkdir system
sudo mount -o loop -t ext4 system.ext4.img system
sudo chmod a+r system/bin/qmuxd

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-vendor-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'| sed -e "s#^-/system/##g"`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ./$FILE $BASE/$FILE

done

for FILE in `cat proprietary-system-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'| sed -e "s#^-/system/##g"`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ./$FILE $BASE/$FILE

done

./setup-makefiles.sh

sudo umount vendor
rm -rf vendor
sudo umount system
rm -rf system
rm -rf angler-mhc19q
rm vendor.ext4.img
rm system.ext4.img
