#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# device.mk (a product makefile) configures the software payload — it's evaluated in the product namespace and
# answers "what ships in the images and how does the OS behave": PRODUCT_PACKAGES (which apps/HALs/daemons get installed —
# your RemovePackages hook), PRODUCT_COPY_FILES (keylayouts, feature XMLs, configs), PRODUCT_PROPERTY_OVERRIDES (system properties),
# inherit-product chains (full_base.mk, wifionly.mk — that whole recent episode was pure product-side). Variables here are PRODUCT_*,
# and changing them means different contents, same packaging.

# API levels
PRODUCT_SHIPPING_API_LEVEL := 27

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    init.class_main.sh \
    init.crda.sh \
    init.mdm.sh \
    init.qcom.class_core.sh \
    init.qcom.coex.sh \
    init.qcom.crashdata.sh \
    init.qcom.early_boot.sh \
    init.qcom.efs.sync.sh \
    init.qcom.post_boot.sh \
    init.qcom.sdio.sh \
    init.qcom.sensors.sh \
    init.qcom.sh \
    init.qcom.syspart_fixup.sh \
    init.qcom.usb.sh \
    init.qcom.wifi.sh \
    init.qti.fm.sh \
    init.qti.ims.sh \
    init.target.usb.sh \
    qca6234-service.sh \

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.msm.usb.configfs.rc \
    init.qcom.factory.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.target.rc \
    init.target.usb.rc \
    init.carrier.rc \
    init.environ.rc \
    init.rc \
    init.recovery.qcom.rc \
    init.solution.rc \
    init.usb.configfs.rc \
    init.usb.rc \
    init.zygote32.rc \
    ueventd.rc \

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/casio/dtx400/dtx400-vendor.mk)
