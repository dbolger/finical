include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = FinicalPrefs

FinicalPrefs_FILES = FCLRootListController.m
FinicalPrefs_INSTALL_PATH = /Library/PreferenceBundles
FinicalPrefs_FRAMEWORKS = UIKit
FinicalPrefs_PRIVATE_FRAMEWORKS = Preferences
FinicalPrefs_CFLAGS = -fobjc-arc
ARCHS = arm64 arm64e
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FinicalPrefs.plist$(ECHO_END)
