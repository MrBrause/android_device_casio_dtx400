LOCAL_PATH := device/casio/dtx400

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Kernel
TARGET_KERNEL_CONFIG := msm8909_defconfig

# Properties
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

# RIL
BOARD_MODEM_TYPE := xmm7260
BOARD_PROVIDES_LIBRIL := true
BOARD_PROVIDES_LIBREFERENCE_RIL := true

# Recovery
TARGET_OTA_ASSERT_DEVICE := dtx400
TW_THEME := portrait_hdpi

# Add RIL-specific SELINUX policy
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0
BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy-ril

# Inherit common board flags
include device/casio/msm8909-common/BoardConfigCommon.mk

# Add RIL-specific HIDL manifest _after_ the common one.
#   Note that LOCAL_PATH gets overwritten by the common
#   board config so we need to explicitly set here again.
LOCAL_PATH := device/casio/dtx400
DEVICE_MANIFEST_FILE += $(LOCAL_PATH)/manifest.xml

# Display
#   Displayed screen was rotated clockwise by 90 degrees
#   but touchscreen reacts as it was not rotated
#SF_PRIMARY_DISPLAY_ORIENTATION := 270

#TW_THEME := landscape_hdpi
#RECOVERY_TOUCHSCREEN_SWAP_XY := true
