#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# BoardConfig.mk configures the build system itself (and is consumed by make, not installed anywhere).
# It answers "how do I build and package for this hardware": target arch and CPU variant, partition sizes and filesystem types,
# kernel source path/defconfig/cmdline (BOARD_KERNEL_CMDLINE — our old friend), what goes into boot.img, SELinux policy dirs,
# HAL build flags (BOARD_WLAN_DEVICE, TARGET_USES_...). Variables here are mostly TARGET_* and BOARD_*,
# and changing them typically means the images are built differently.

DEVICE_PATH := device/casio/dtx400

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_USES_64_BIT_BINDER := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := dtx400
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 androidboot.memcg=false earlyprintk loglevel=8 log_buf_len=512K buildvariant=user androidboot.abl= androidboot.bootloader=L4TAZ000TA00
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
TARGET_KERNEL_CONFIG := msm8909_defconfig
TARGET_KERNEL_SOURCE := kernel/casio/dtx400

# Kernel - prebuilt
#TARGET_FORCE_PREBUILT_KERNEL := true
#ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
#endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 115343360
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10853243392 #16K reserved for possible encryption footer

# Platform
TARGET_BOARD_PLATFORM := msm8909

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2024-01-05

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Inherit the proprietary files
include vendor/casio/dtx400/BoardConfigVendor.mk
