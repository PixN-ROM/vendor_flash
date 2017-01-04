# Written for UBER toolchains (UBERTC)
# Requires a Linux Host

UNAME := $(shell uname -s)
ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

ifeq (linux,$(HOST_OS))
  PROP_CLANG_VERSION := $(shell prebuilts/clang/host/$(HOST_PREBUILT_TAG)/$(LLVM_PREBUILTS_VERSION)/bin/clang --version | grep "clang " | cut -d ' ' -f 3 2>&1)

  ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.clang=$(PROP_CLANG_VERSION)

  $(info Clang version for build.prop: '$(PROP_CLANG_VERSION)')

  ifeq (arm,$(TARGET_ARCH))

    # ANDROIDEABI TOOLCHAIN INFO
    PROP_GCC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)
    PROP_GCC_VERSION := $(shell $(PROP_GCC_PATH)/bin/arm-linux-androideabi-gcc --version 2>&1)
    PROP_GCC_VERSION_NUMBER := $(shell $(PROP_GCC_PATH)/bin/arm-linux-androideabi-gcc -dumpversion 2>&1)
    PROP_GCC_DATE := $(filter 20150% 20151% 20160% 20161% 20170% 20171% 20180% 20181%,,$(PROP_GCC_VERSION))

    ifeq (,$(PROP_GCC_DATE))
      PROP_GCC_TEXT := $(PROP_GCC_VERSION_NUMBER)
    else	
      PROP_GCC_TEXT := $(PROP_GCC_VERSION_NUMBER)-$(PROP_GCC_DATE)
    endif

    ADDITIONAL_BUILD_PROPERTIES += \
      ro.build.gcc=$(PROP_GCC_TEXT)

  else ifeq (arm64,$(TARGET_ARCH))

    # AARCH64 TOOLCHAIN INFO
    ifneq ($(TARGET_GCC_VERSION_ARM64),)
      PROP_GCC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_GCC_VERSION_ARM64)
    else
      PROP_GCC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9
    endif

    PROP_GCC_VERSION := $(shell $(PROP_GCC_PATH)/bin/aarch64-linux-android-gcc --version)
    PROP_GCC_VERSION_NUMBER := $(shell $(PROP_GCC_PATH)/bin/aarch64-linux-android-gcc -dumpversion 2>&1)
    PROP_GCC_DATE := $(filter 20150% 20151% 20160% 20161% 20170% 20171% 20180% 20181%,,$(PROP_GCC_VERSION))

    ifeq (,$(PROP_GCC_DATE))
      PROP_GCC_TEXT := $(PROP_GCC_VERSION_NUMBER)
    else
      PROP_GCC_TEXT := $(PROP_GCC_VERSION_NUMBER)-$(PROP_GCC_DATE)
    endif

    ADDITIONAL_BUILD_PROPERTIES += \
      ro.build.gcc=$(PROP_GCC_TEXT)
  endif

  $(info GCC version for build.prop: '$(PROP_GCC_TEXT)')

endif
