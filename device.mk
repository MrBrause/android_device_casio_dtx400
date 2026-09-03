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

# ADB
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.state=mass_storage,adb \
    persist.sys.usb.config=mass_storage,adb \
    ro.debuggable=1 \
    service.adb.root=1 \
    ro.adb.secure=0 \
    ro.secure=0 \
    sys.usb.controller=msm_hsusb \
    sys.usb.configfs=0

PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.usb.config=mass_storage,adb

# Audio
TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_PACKAGES += \
    audio.primary.msm8909 \
    android.hardware.soundtrigger@2.0-impl

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl

# libs were created but not copied to the needed location
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/android.hardware.audio.common@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hardware.audio.common@2.0.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/android.hardware.broadcastradio@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hardware.broadcastradio@1.0.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/android.hardware.broadcastradio@1.1.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hardware.broadcastradio@1.1.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/android.hardware.soundtrigger@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hardware.soundtrigger@2.0.so

# override AOSP audio service with the one from stock
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/audio-hal-2-0.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.audio.service.rc

# libaudioroute from VNDK v28 prebuilts for legacy audio HAL
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/libaudioroute.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudioroute.so

# for VNDK libs, the correct approach is to pull from the VNDK v28 prebuilts
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/libaudioutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudioutils.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/libtinyalsa.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtinyalsa.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-core/libexpat.so:$(TARGET_COPY_OUT_VENDOR)/lib/libexpat.so

# audio policy configs and mixer paths also needed to start HAL
PRODUCT_COPY_FILES += \
    vendor/casio/dtx400/proprietary/vendor/etc/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml \
    vendor/casio/dtx400/proprietary/vendor/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    vendor/casio/dtx400/proprietary/vendor/etc/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf \
    vendor/casio/dtx400/proprietary/vendor/etc/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    vendor/casio/dtx400/proprietary/vendor/etc/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf \
    vendor/casio/dtx400/proprietary/vendor/etc/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_msm8909_pm8916.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_msm8909_pm8916.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# the mixer_paths.xml is the default fallback, but mixer_paths_msm8909_pm8916.xml seems to be the right one, as it comes from Stock
#PRODUCT_COPY_FILES += \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_qrd_skut.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skut.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_wcd9326_i2s.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_wcd9326_i2s.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_skuc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_skuc.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_qrd_skuh.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skuh.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_skua.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_skua.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_skue.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_skue.xml \
#    vendor/casio/dtx400/proprietary/vendor/etc/mixer_paths_qrd_skui.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skui.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/bpfloader_mock.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/bpfloader

# Bluetooth profiles (A13 Gabeldorsche stack reads these at BT start)
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.profile.a2dp.source.enabled?=true \
    bluetooth.profile.avrcp.target.enabled?=true \
    bluetooth.profile.gatt.enabled?=true \
    bluetooth.profile.hfp.ag.enabled?=true \
    bluetooth.profile.hid.host.enabled?=true \
    bluetooth.profile.opp.enabled?=true \
    bluetooth.profile.pan.nap.enabled?=true \
    bluetooth.profile.pan.panu.enabled?=true \
    bluetooth.profile.pbap.server.enabled?=true

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

# Fix SurfaceFlinger crash on old Adreno GPU
# Abort message: 'Unable to generate SkImage. isTextureValid:1 dataspace:513'
PRODUCT_PROPERTY_OVERRIDES += \
    debug.renderengine.backend=gles \
    service.sf.prime_shader_cache=0

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=msm8909 \
    ro.hardware.egl=adreno \
    debug.sf.hw=0 \

# Disable Vulkan
PRODUCT_PROPERTY_OVERRIDES += \
    persist.graphics.vulkan.disable=true \
    ro.opengles.version=196608

# GNSS service disabled — no GPS receiver on this SKU (see commit msg).
# Ship a disabled .rc; keep the binary/libs for a future WC21/RIL variant.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/vendor.qti.gnss@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.gnss@1.0-service.rc

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# creates an empty shared library that satisfies the linker
# who needs entry without providing any symbols
# the ProcessState symbols will be resolved from libhidlbase.so
PRODUCT_PACKAGES += \
    libhwbinder_stub

PRODUCT_COPY_FILES += \
    vendor/casio/dtx400/proprietary/vendor/lib/android.hidl.base@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hidl.base@1.0.so

PRODUCT_PACKAGES += \
    libhidltransport-shim \
    libcompat-shim \
    libgps-shim \
    libwifi-shim \
    libhwminijail

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

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

# USB
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.target.usb.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.target.usb.sh \
    $(LOCAL_PATH)/rootdir/etc/init.target.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.usb.rc

# Wifi
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_COPY_FILES += \
    external/wpa_supplicant_8/wpa_supplicant/aidl/android.hardware.wifi.supplicant-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.wifi.supplicant-service.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/wcnss_macaddr_setup.sh:$(TARGET_COPY_OUT_VENDOR)/bin/wcnss_macaddr_setup.sh

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    libwifi-hal-ctrl \
    hostapd \
    android.hardware.wifi.supplicant@1.0 \
    wpa_supplicant

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# VNDK
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v31/arm/arch-arm-armv7-a-neon/shared/vndk-core/libbinder.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbinder-v31.so \
    prebuilts/vndk/v31/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libhidlbase.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhidlbase-v31.so \
    prebuilts/vndk/v31/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils-v31.so \
    prebuilts/vndk/v32/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils-v32.so \
    prebuilts/vndk/v30/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libhidlbase.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhidlbase.so \
    device/casio/dtx400/prebuilts/lib/libhidltransport.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhidltransport.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libhidlmemory.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhidlmemory.so \
    prebuilts/vndk/v30/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libcutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcutils.so \
    prebuilts/vndk/v30/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils.so \
    prebuilts/vndk/v28/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libbase.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbase.so \
    prebuilts/vndk/v30/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libc++.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc++.so

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/casio/dtx400/dtx400-vendor.mk)
