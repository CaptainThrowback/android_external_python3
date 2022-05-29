#
# Copyright (C) 2022 Captain_Throwback
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

ifneq ($(TW_EXCLUDE_PYTHON),true)
    # Dummy file to copy prebuilt python files
    include $(CLEAR_VARS)
    LOCAL_MODULE := python3_bin
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)

    LOCAL_POST_INSTALL_CMD += \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/bin; \
        cp -rf $(LOCAL_PATH)/prebuilt/common/bin $(TARGET_RECOVERY_ROOT_OUT)/system/;

    ifeq ($(TARGET_ARCH),arm64)
        LOCAL_POST_INSTALL_CMD += \
            cp -rf $(LOCAL_PATH)/prebuilt/arm64/bin $(TARGET_RECOVERY_ROOT_OUT)/system/;
    else
        LOCAL_POST_INSTALL_CMD += \
            cp -rf $(LOCAL_PATH)/prebuilt/arm/bin $(TARGET_RECOVERY_ROOT_OUT)/system/;
    endif
    include $(BUILD_PHONY_PACKAGE)

    include $(CLEAR_VARS)
    LOCAL_MODULE := python3_lib
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)

    LOCAL_POST_INSTALL_CMD += \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/etc/python; \
        cp -rf $(LOCAL_PATH)/prebuilt/common/lib $(TARGET_RECOVERY_ROOT_OUT)/system/etc/python/;

    ifeq ($(TARGET_ARCH),arm64)
        LOCAL_POST_INSTALL_CMD += \
            cp -rf $(LOCAL_PATH)/prebuilt/arm64/lib $(TARGET_RECOVERY_ROOT_OUT)/system/etc/python/;
    else
        LOCAL_POST_INSTALL_CMD += \
            cp -rf $(LOCAL_PATH)/prebuilt/arm/lib $(TARGET_RECOVERY_ROOT_OUT)/system/etc/python/;
    endif
    include $(BUILD_PHONY_PACKAGE)

    include $(CLEAR_VARS)
    LOCAL_MODULE := python3_scripts
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)

    LOCAL_POST_INSTALL_CMD += \
        cp -rf $(LOCAL_PATH)/scripts $(TARGET_RECOVERY_ROOT_OUT)/system/etc/python/;
    include $(BUILD_PHONY_PACKAGE)
endif
