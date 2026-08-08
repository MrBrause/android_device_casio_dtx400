#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),dtx400)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif

ifeq ($(TARGET_USES_GRALLOC1),true)
display_top := hardware/qcom/display/msm8909w_3100
include hardware/qcom/display/msm8909w_3100/libgralloc1/Android.mk
endif
