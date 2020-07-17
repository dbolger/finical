#line 1 "Tweak.x"

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBMediaController; @class PLPlatterCustomContentView; @class CSMediaControlsView; @class CSAdjunctListItemView; @class SBLockScreenManager; @class SBMainSwitcherViewController; @class QRTMediaModuleViewController; 
static void _logos_meta_method$_ungrouped$CSMediaControlsView$removePlayer(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static void _logos_meta_method$_ungrouped$CSMediaControlsView$stateChanged$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSNotification *); static void (*_logos_orig$_ungrouped$CSMediaControlsView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSMediaControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CSAdjunctListItemView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL CSAdjunctListItemView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSAdjunctListItemView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSAdjunctListItemView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$QRTMediaModuleViewController$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL QRTMediaModuleViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$QRTMediaModuleViewController$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL QRTMediaModuleViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$PLPlatterCustomContentView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL PLPlatterCustomContentView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PLPlatterCustomContentView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL PLPlatterCustomContentView* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBMainSwitcherViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBMainSwitcherViewController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBLockScreenManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBLockScreenManager"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$CSMediaControlsView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("CSMediaControlsView"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBMediaController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBMediaController"); } return _klass; }
#line 1 "Tweak.x"
#import <Headers.h>
static BOOL enabled = YES;
static BOOL dismissPlayer = NO;
static BOOL killApp = NO;
static int timeOption = 0;
static int dismissGesture = 2;
static int timeValue = 0;
static id prefs;
static void reloadSettings() {
	prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.5px.finical.plist"];
	if(prefs) {
		enabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] intValue] : enabled;
		dismissPlayer = [prefs objectForKey:@"dismissPlayer"] ? [[prefs objectForKey:@"dismissPlayer"] intValue]: dismissPlayer;
		killApp = [prefs objectForKey:@"killApp"] ? [[prefs objectForKey:@"killApp"] intValue]: killApp;
		timeOption = [prefs objectForKey:@"timeOption"] ? [[prefs objectForKey:@"timeOption"] intValue]: timeOption;
		timeValue = [prefs objectForKey:@"timeValue"] ? [[prefs objectForKey:@"timeValue"] intValue]: timeValue;
		dismissGesture = [prefs objectForKey:@"dismissGesture"] ? [[prefs objectForKey:@"dismissGesture"] intValue]: dismissGesture;
		if (dismissPlayer) {
			switch (timeOption) {
				case 0:
					break;
				case 1:
					timeValue = timeValue * 60;
					break;
				case 2:
					timeValue = timeValue * 3600;
					break;
			}
		}
	}
}
 
CSAdjunctListItem *item;
SBLockScreenManager *manager;
CSNotificationAdjunctListViewController *vc;
NSTimer *timer;
SBMainSwitcherViewController *mainSwitcher;
NSString *nowPlayingID;
NSArray *items;

static void _logos_meta_method$_ungrouped$CSMediaControlsView$removePlayer(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	if ([[_logos_static_class_lookup$SBMediaController() sharedInstance] isPaused]) {
		if ([vc.identifiersToItems count] >= 1) { 
			[vc _removeItem:(id)item animated:(BOOL)YES];
			if (killApp) {
				for (SBAppLayout *item in items) {
					SBDisplayItem *currentItem = [item.rolesToLayoutItemsMap objectForKey:@1];
					NSString *bundleID = currentItem.bundleIdentifier;
					if ([bundleID isEqualToString: nowPlayingID]) {
						[mainSwitcher _deleteAppLayout:item forReason: 1];
					}
				}       
			}
		}       
	}
}

static void _logos_meta_method$_ungrouped$CSMediaControlsView$stateChanged$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSNotification * notification) {
	if ([[_logos_static_class_lookup$SBMediaController() sharedInstance] isPlaying]) {
		if ([vc.identifiersToItems count] == 0) {
			[vc _insertItem:(id)item animated:(BOOL)YES];
		}
	}
	if ([timer isValid]) {
		[timer invalidate];
		timer = nil;
	}
	if (enabled) {
		if ([vc.identifiersToItems count] == 1) {
			if (dismissPlayer) {
				timer = [NSTimer scheduledTimerWithTimeInterval: timeValue
					target: _logos_static_class_lookup$CSMediaControlsView()
					selector: @selector(removePlayer)
					userInfo: nil
					repeats: NO];
			}
		}
	}
}
static void _logos_method$_ungrouped$CSMediaControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	reloadSettings();
	manager = [_logos_static_class_lookup$SBLockScreenManager() sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	item = [vc.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
	mainSwitcher = [_logos_static_class_lookup$SBMainSwitcherViewController() sharedInstance];
	items = mainSwitcher.recentAppLayouts;
	nowPlayingID = [[[_logos_static_class_lookup$SBMediaController() sharedInstance] nowPlayingApplication] bundleIdentifier];
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:_logos_static_class_lookup$CSMediaControlsView() action:@selector(removePlayer)];
	switch (dismissGesture) {
		case 1: 
			gesture.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		case 2:
			gesture.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 3:
			gesture.direction = UISwipeGestureRecognizerDirectionDown;
			break;
		default:
			gesture.direction = UISwipeGestureRecognizerDirectionLeft;	
			break;
	}
	[self addGestureRecognizer:gesture];
	_logos_orig$_ungrouped$CSMediaControlsView$layoutSubviews(self, _cmd);
}


static void _logos_method$_ungrouped$CSAdjunctListItemView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSAdjunctListItemView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:_logos_static_class_lookup$CSMediaControlsView()  action:@selector(removePlayer)];
	switch (dismissGesture) {
		case 0:
			gesture.direction = UISwipeGestureRecognizerDirectionLeft;
			break;
		case 1: 
			gesture.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		case 2:
			gesture.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 3:
			gesture.direction = UISwipeGestureRecognizerDirectionDown;
			break;
	}
	[self addGestureRecognizer:gesture];
	_logos_orig$_ungrouped$CSAdjunctListItemView$layoutSubviews(self, _cmd);
}


static void _logos_method$_ungrouped$QRTMediaModuleViewController$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL QRTMediaModuleViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:_logos_static_class_lookup$CSMediaControlsView()  action:@selector(removePlayer)];
	switch (dismissGesture) {
		case 0:
			gesture.direction = UISwipeGestureRecognizerDirectionLeft;
			break;
		case 1: 
			gesture.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		case 2:
			gesture.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 3:
			gesture.direction = UISwipeGestureRecognizerDirectionDown;
			break;
	}
	[self addGestureRecognizer:gesture];
	_logos_orig$_ungrouped$QRTMediaModuleViewController$layoutSubviews(self, _cmd);
}


static void _logos_method$_ungrouped$PLPlatterCustomContentView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL PLPlatterCustomContentView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:_logos_static_class_lookup$CSMediaControlsView()  action:@selector(removePlayer)];
	switch (dismissGesture) {
		case 0:
			gesture.direction = UISwipeGestureRecognizerDirectionLeft;
			break;
		case 1: 
			gesture.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		case 2:
			gesture.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 3:
			gesture.direction = UISwipeGestureRecognizerDirectionDown;
			break;
	}
	[self addGestureRecognizer:gesture];
	_logos_orig$_ungrouped$PLPlatterCustomContentView$layoutSubviews(self, _cmd);
}

static __attribute__((constructor)) void _logosLocalCtor_b2403fe0(int __unused argc, char __unused **argv, char __unused **envp) {
	reloadSettings();
	[[NSNotificationCenter defaultCenter] addObserver:_logos_static_class_lookup$CSMediaControlsView() selector:@selector(stateChanged:) name:@"SBMediaNowPlayingChangedNotification" object:nil];
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CSMediaControlsView = objc_getClass("CSMediaControlsView"); Class _logos_metaclass$_ungrouped$CSMediaControlsView = object_getClass(_logos_class$_ungrouped$CSMediaControlsView); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_metaclass$_ungrouped$CSMediaControlsView, @selector(removePlayer), (IMP)&_logos_meta_method$_ungrouped$CSMediaControlsView$removePlayer, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSNotification *), strlen(@encode(NSNotification *))); i += strlen(@encode(NSNotification *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_metaclass$_ungrouped$CSMediaControlsView, @selector(stateChanged:), (IMP)&_logos_meta_method$_ungrouped$CSMediaControlsView$stateChanged$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CSMediaControlsView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$CSMediaControlsView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$CSMediaControlsView$layoutSubviews);Class _logos_class$_ungrouped$CSAdjunctListItemView = objc_getClass("CSAdjunctListItemView"); MSHookMessageEx(_logos_class$_ungrouped$CSAdjunctListItemView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$CSAdjunctListItemView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$CSAdjunctListItemView$layoutSubviews);Class _logos_class$_ungrouped$QRTMediaModuleViewController = objc_getClass("QRTMediaModuleViewController"); MSHookMessageEx(_logos_class$_ungrouped$QRTMediaModuleViewController, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$QRTMediaModuleViewController$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$QRTMediaModuleViewController$layoutSubviews);Class _logos_class$_ungrouped$PLPlatterCustomContentView = objc_getClass("PLPlatterCustomContentView"); MSHookMessageEx(_logos_class$_ungrouped$PLPlatterCustomContentView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$PLPlatterCustomContentView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$PLPlatterCustomContentView$layoutSubviews);} }
#line 175 "Tweak.x"
