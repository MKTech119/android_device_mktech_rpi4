#
# Copyright 2020 Android-RPi Project
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
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/generic/car/common/car.mk)

PRODUCT_NAME := mktech_car_rpi4
PRODUCT_DEVICE := mktech_car_rpi4
PRODUCT_BRAND := aarpi
PRODUCT_MANUFACTURER := ARPi
PRODUCT_MODEL := Android Automotive on Raspberry Pi 4

include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk

PRODUCT_PROPERTY_OVERRIDES += \
    debug.drm.mode.force=1280x720 \
    gralloc.drm.kms=/dev/dri/card0 \
    gralloc.drm.device=/dev/dri/card1 \
    ro.opengles.version=196609 \
    ro.hardware.vulkan=rpi4 \
    wifi.interface=wlan0 \
    ro.rfkilldisabled=1

PRODUCT_SOONG_NAMESPACES += external/mesa3d

# system packages
PRODUCT_PACKAGES += \
    libGLES_mesa \
    gralloc.rpi4 \
    vulkan.rpi4 \
    memtrack.rpi4 \
    audio.primary.rpi4 \
    audio.usb.default \
    audio.a2dp.default \
    audio.r_submix.default \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_supplicant.conf \
    libbt-vendor

# hardware/interfaces
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-service.rpi4 \
    android.hardware.graphics.mapper@2.0-impl.rpi4 \
    android.hardware.graphics.composer@2.1-service.rpi4 \
    android.hardware.camera.provider@2.5-external-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.audio@2.0-service \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \
    android.hardware.gatekeeper@1.0-service.software \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl \
    android.hardware.health.storage@1.0-service \
    android.hardware.wifi@1.0-service \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.configstore@1.1-service \
    vndservicemanager
    
# Auto modules
PRODUCT_PACKAGES += \
            android.hardware.broadcastradio@2.0-service \
            android.hardware.automotive.vehicle@2.0-service

# Additional selinux policy
BOARD_SEPOLICY_DIRS += device/google_car/common/sepolicy

PRODUCT_PACKAGES += \
            android.hardware.automotive.audiocontrol@1.0-service

# Car init.rc
PRODUCT_COPY_FILES += \
            packages/services/Car/car_product/init/init.bootstat.rc:root/init.bootstat.rc \
            packages/services/Car/car_product/init/init.car.rc:root/init.car.rc

# broadcast radio feature
 PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.broadcastradio.xml:system/etc/permissions/android.hardware.broadcastradio.xml
        
# EVS v1.1
PRODUCT_PACKAGES += android.automotive.evs.manager@1.1 \
                    android.hardware.automotive.evs@1.1-sample \
                    evs_app
PRODUCT_PRODUCT_PROPERTIES += persist.automotive.evs.mode=0

# Sepolicy for EVS
include packages/services/Car/evs/sepolicy/evs.mk

# Automotive display service
PRODUCT_PACKAGES += android.frameworks.automotive.display@1.0-service

# Pre-create users
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    android.car.number_pre_created_users=1 \
    android.car.number_pre_created_guests=1 \
    android.car.user_hal_enabled=true

# Enable landscape
PRODUCT_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml

# Vendor Interface Manifest
PRODUCT_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.broadcastradio.xml:system/etc/permissions/android.hardware.broadcastradio.xml
            
TARGET_USES_CAR_FUTURE_FEATURES := true

# system configurations
PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:system/etc/permissions/android.hardware.type.automotive.xml \
    hardware/broadcom/wlan/bcmdhd/config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.external.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml \
    $(LOCAL_PATH)/init.usb.rc:root/init.usb.rc \
    $(LOCAL_PATH)/init.rpi4.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.rc \
    $(LOCAL_PATH)/init.rpi4.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.usb.rc \
    $(LOCAL_PATH)/ueventd.rpi4.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(LOCAL_PATH)/fstab.rpi4:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.rpi4 \
    $(LOCAL_PATH)/fstab.rpi4:$(TARGET_COPY_OUT_RAMDISK)/fstab.rpi4 \
    $(LOCAL_PATH)/Generic.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Generic.kl \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.bin:root/lib/firmware/brcm/brcmfmac43455-sdio.bin \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.bin \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.clm_blob:root/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.txt:root/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt \
    $(LOCAL_PATH)/firmware/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt \
    $(LOCAL_PATH)/firmware/brcm/BCM4345C0.hcd:root/lib/firmware/brcm/BCM4345C0.hcd \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    $(PRODUCT_COPY_FILES)

# media configurations
PRODUCT_COPY_FILES := \
    device/generic/goldfish/camera/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml \
    device/generic/goldfish/camera/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libeffects/data/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/base/data/sounds/effects/ogg/Effect_Tick_48k.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/Effect_Tick.ogg \
    frameworks/base/data/sounds/effects/ogg/camera_click_48k.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/camera_click.ogg \
    $(PRODUCT_COPY_FILES)

DEVICE_PACKAGE_OVERLAYS := device/mktech/mktech_car_rpi4/overlay
PRODUCT_CHARACTERISTICS := automotive

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
