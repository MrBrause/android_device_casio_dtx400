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

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_USES_64_BIT_BINDER := true

# Audio
BOARD_USES_ALSA_AUDIO := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := dtx400
TARGET_NO_BOOTLOADER := true

# cmdline from bootloader, read via LK2ND
# androidboot.bootdevice=7824900.sdhci androidboot.verifiedbootstate=orange androidboot.veritymode=enforcing
# androidboot.keymaster=1 androidboot.safemode=0 androidboot.uartflag=0 androidboot.admin.root=0 androidboot.shortcode=1XL androidboot.serialno=MQ1C00557LA058
# androidboot.baseband=apq mdss_mdp3.panel=1:dsi:0:qcom,mdss_dsi_st7701s_wvga_video:1:none:cfg:single_dsi

# cmdline from stock OS
# sched_enable_hmp=1 console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci
# lpm_levels.sleep_disabled=1 androidboot.memcg=false earlyprintk loglevel=8 log_buf_len=512K buildvariant=user androidboot.abl= androidboot.bootloader=L4TAZ000TA00

# Kernel
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_HEADER_ARCH := arm
TARGET_KERNEL_VERSION := 3.18
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8
BOARD_KERNEL_CMDLINE += androidboot.console=ttyHSL0
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.fstab_suffix=qcom
BOARD_KERNEL_CMDLINE += clk_ignore_unused
BOARD_KERNEL_CMDLINE += androidboot.memcg=false
BOARD_KERNEL_CMDLINE += log_buf_len=4M earlyprintk=android
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive enforcing=0
BOARD_KERNEL_CMDLINE += cgroup_disable=cpuacct
BOARD_KERNEL_CMDLINE += loglevel=7
BOARD_KERNEL_CMDLINE += ignore_loglevel
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
TARGET_KERNEL_CONFIG := msm8909_defconfig
TARGET_KERNEL_SOURCE := kernel/casio/dtx400

# Kernel Toolchain
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-
KERNEL_TOOLCHAIN_PREFIX := arm-linux-androideabi-
KERNEL_TOOLCHAIN := $(shell pwd)/prebuilts/gcc/$(HOST_OS)-x86/arm/arm-linux-androideabi-4.9/bin

# it is enabled per default and useful for kernel 4.14 and newer
# disable it explicitly
#TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_COMPILE := false

# ensure common_deps and kernel_includes under in hardware/qcom/display/msm8909/common.mk are set
# Tell the build system to generate headers out of your custom kernel path
TARGET_HAS_LEGACY_QSGI := true
TARGET_COMPILE_WITH_MSM_KERNEL := true
PRODUCT_SOONG_NAMESPACES += \
    kernel/casio/dtx400

# Kernel - prebuilt
#TARGET_FORCE_PREBUILT_KERNEL := true
#ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
#endif

# Metadata
# create /metadata mountpoint in the ramdisk, fstab entry is also needed
BOARD_USES_METADATA_PARTITION := true

# Filesystem
BOARD_ROOT_EXTRA_FOLDERS := firmware persist

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

# Graphics
# Force system allocation frameworks to use Mapper 2.0 compatibility layers
USE_LEGACY_GRALLOC := true
TARGET_USES_OLD_M_DOMAINS := true

# Force compatibility with older Gralloc 1 / Mapper 2 architectures
# Disable modern HIDL/AIDL Mapper 4.0 enforcement loops
TARGET_USES_GRALLOC1 := true
TARGET_USES_ION := true

# Disable modern rendering options that your MSM8909 GPU/Kernel cannot parse
TARGET_USES_VULKAN := false
TARGET_NOT_HAVE_YUV_AVC_RGB := true

# Disable modern Gralloc 3/4 binders entirely
TARGET_USES_GRALLOC4 := false
TARGET_USES_DRM_PP := false

TARGET_USES_HWC2 := true

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2024-01-05

# Separate vendor.img
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_PARTITION_SIZE := 524288000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# SEpolicy
include device/qcom/sepolicy-legacy-um/SEPolicy.mk

BOARD_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor

BOARD_VENDOR_SEPOLICY_DIRS += \
    device/qcom/sepolicy-legacy-um/legacy/vendor/common \
    device/qcom/sepolicy-legacy-um/legacy/vendor/common/debugfs \
    device/qcom/sepolicy-legacy-um/legacy/vendor/ssg \
    device/qcom/sepolicy-legacy-um/legacy/vendor/test \
    device/qcom/sepolicy-legacy-um/legacy/vendor/test/debugfs

# VINTF
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/vintf/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(DEVICE_PATH)/vintf/framework_manifest.xml
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/vintf/product_matrix.xml

# Inherit the proprietary files
include vendor/casio/dtx400/BoardConfigVendor.mk
