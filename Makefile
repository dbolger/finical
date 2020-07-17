PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)
INSTALL_TARGET_PROCESSES = SpringBoard 

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Finical
Finical_PRIVATE_FRAMEWORKS = CoverSheet MediaRemote
Finical_FILES = Tweak.x
Finical_CFLAGS = -fobjc-arc
ARCHS = arm64 arm64e
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += finicalprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
