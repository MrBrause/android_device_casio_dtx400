#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from dtx400 device
$(call inherit-product, device/casio/dtx400/device.mk)

PRODUCT_DEVICE := dtx400
PRODUCT_NAME := lineage_dtx400
PRODUCT_BRAND := CASIO
PRODUCT_MODEL := DT-X400
PRODUCT_MANUFACTURER := casio

PRODUCT_GMS_CLIENTID_BASE := android-casio

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="dtx400-user 8.1.0 OPM1.171019.026 R212 release-keys"

BUILD_FINGERPRINT := CASIO/dtx400/dtx400:8.1.0/OPM1.171019.026/R212:user/release-keys
