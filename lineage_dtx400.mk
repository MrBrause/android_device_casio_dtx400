# Copyright (C) 2013-2016, The CyanogenMod Project
# Copyright (C) 2017, The LineageOS Project
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

# Inherit device configuration
$(call inherit-product, device/casio/dtx400/device.mk)
$(call inherit-product, device/casio/msm8909-common/device-common.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common LineageOS stuff.
#$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product, vendor/lineage/config/telephony.mk)

# Inherit some common Twrp stuff.
#$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_NAME := lineage_dtx400
PRODUCT_DEVICE := dtx400
PRODUCT_BRAND := casio
PRODUCT_MODEL := DT-X400
PRODUCT_MANUFACTURER := casio

PRODUCT_BUILD_PROP_OVERRIDES += \
  PRODUCT_NAME=dtx400 \
  TARGET_DEVICE=dtx400 \
  PRIVATE_BUILD_DESC="dtx400-user 8.1.0 OPM1.171019.026 R176 release-keys"

BUILD_FINGERPRINT := CASIO/dtx400/dtx400:8.1.0/OPM1.171019.026/R176:user/release-keys

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/oat/%/org.lineageos.platform.odex \
    system/framework/oat/%/org.lineageos.platform.vdex \
    system/framework/oat/arm/org.lineageos.platform.odex \
    system/framework/oat/arm/org.lineageos.platform.vdex
