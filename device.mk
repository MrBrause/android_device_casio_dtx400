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

LOCAL_PATH := device/casio/dtx400

# API levels
PRODUCT_SHIPPING_API_LEVEL := 27

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/bpfloader_mock.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/bpfloader

# writes logcat to /data/misc/logd/ persistently
PRODUCT_PROPERTY_OVERRIDES += \
    logd.logpersistd=logcatd \
    logd.logpersistd.buffer=all \
    logd.logpersistd.rotate_kbytes=2048

# Pre-compile all apps at build time, not just boot image
WITH_DEXPREOPT := true
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := false
WITH_DEXPREOPT_DEBUG_INFO := false
#DONT_DEXPREOPT_PREBUILTS := true
# Change first-boot strategy to use pre-compiled odex
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile
# Dex
PRODUCT_DEXPREOPT_SPEED_APPS += \
    TrebuchetQuickStep \
    Settings \
    SystemUI

# Graphics
PRODUCT_PACKAGES += \
    libqdutils \
    libqdMetaData \
    libqdMetaData.system \
    libmemalloc \
    libqservice \
    libgrallocutils \
    gralloc.msm8909 \
    hwcomposer.msm8909

PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-service

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=msm8909

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/android.hardware.graphics.composer@2.1-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.composer@2.1-service.rc \
    $(LOCAL_PATH)/rootdir/etc/android.hardware.graphics.allocator@2.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.allocator@2.0-service.rc

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Init
PRODUCT_PACKAGES += \
    init \
    init.rc \
    toolbox

# Fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom

# Scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.early_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.early_boot.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.post_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.post_boot.sh

# RC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.rc \
    $(LOCAL_PATH)/rootdir/etc/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.rc \
    $(LOCAL_PATH)/rootdir/etc/init.solution.rc:root/init.solution.rc \
    $(LOCAL_PATH)/rootdir/etc/init.carrier.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.carrier.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
    system/core/rootdir/init.rc:root/init.rc

# Profiles
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/profiles/cgroups_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    $(LOCAL_PATH)/profiles/task_profiles_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/casio/dtx400/dtx400-vendor.mk)
