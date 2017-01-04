# Copyright (C) 2016 The Pure Nexus Project
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

# Include custom telephony configuration
include vendor/pixN/configs/custom_phone.mk

# Inherit AOSP device configuration for angler
$(call inherit-product, device/huawei/angler/aosp_angler.mk)

# Override AOSP build properties
PRODUCT_NAME := angler
PRODUCT_BRAND := google
PRODUCT_DEVICE := angler
PRODUCT_MODEL := Nexus 6P
PRODUCT_MANUFACTURER := Huawei

# Export optimization flags
O3_OPTS := true
STRICT_ALIASING := true
POLLY_OPTS := true
GRAPHITE_OPTS := true

# Copy over our ramdisk files
PRODUCT_COPY_FILES += \
    vendor/pixN/prebuilt/etc/init.pixN.rc:root/init.pixN.rc \
    vendor/pixN/prebuilt/etc/init.performance_profiles.rc:root/init.performance_profiles.rc \
    vendor/pixN/prebuilt/etc/init.special_power.sh:root/init.special_power.sh \
    vendor/pixN/prebuilt/etc/msm_irqbalance.conf:root/msm_irqbalance.conf

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=angler \
    BUILD_FINGERPRINT=google/angler/angler:7.1.1/NMF26F/3425388:user/release-keys \
    PRIVATE_BUILD_DESC="angler-user 7.1.1 NMF26F 3425388 release-keys"
