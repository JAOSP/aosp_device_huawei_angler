#
# Copyright 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Get the long list of APNs
PRODUCT_COPY_FILES := device/huawei/angler/apns-full-conf.xml:system/etc/apns-conf.xml

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=angler TARGET_DEVICE=angler BUILD_FINGERPRINT=google/angler/angler:6.0.1/MMB29P/2473553:user/release-keys PRIVATE_BUILD_DESC="angler-user 6.0.1 MMB29P 2473553 release-keys"

PRODUCT_NAME := full_angler
PRODUCT_DEVICE := angler
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 6P
PRODUCT_MANUFACTURER := Huawei
PRODUCT_RESTRICT_VENDOR_FILES := true

$(call inherit-product, device/huawei/angler/device.mk)
$(call inherit-product-if-exists, vendor/huawei/angler/device-vendor.mk)
$(call inherit-product-if-exists, vendor/huawei/angler/angler-vendor.mk)
$(call inherit-product-if-exists, vendor/aosp/huawei/angler/full.mk)
$(call inherit-product, device/aosp/common/full.mk)

PRODUCT_PACKAGES += \
    Launcher3

JAOSP_SYMLINK := true
JAOSP_VENDOR_NAME := huawei
JAOSP_DEVICE_NAME := angler
