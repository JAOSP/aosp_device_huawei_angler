#!/bin/sh

VENDOR=huawei
DEVICE=angler

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/angler-mdb08m-factory-dbc17940.tgz
tar zxf angler-mdb08m-factory-dbc17940.tgz
rm angler-mdb08m-factory-dbc17940.tgz
cd angler-mdb08m
unzip image-angler-mdb08m.zip
rm image-angler-mdb08m.zip
cd ../
./simg2img angler-mdb08m/vendor.img vendor.ext4.img
mkdir vendor
sudo mount -o loop -t ext4 vendor.ext4.img vendor
./simg2img angler-mdb08m/system.img system.ext4.img
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
rm -rf angler-mdb08m
rm vendor.ext4.img
rm system.ext4.img
