#line 1 "Tweak.x"
#import <Headers.h>


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

@class SBLockScreenManager; @class SBMediaController; @class CSMediaControlsView; 
static CSAdjunctListItem * _logos_method$_ungrouped$CSMediaControlsView$getPlayerItem(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSMediaControlsView$removePlayer(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSMediaControlsView$playbackStateChanged(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CSMediaControlsView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSMediaControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBMediaController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBMediaController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBLockScreenManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBLockScreenManager"); } return _klass; }
#line 3 "Tweak.x"
 
SBLockScreenManager *manager;
CSNotificationAdjunctListViewController *vc;


static CSAdjunctListItem * _logos_method$_ungrouped$CSMediaControlsView$getPlayerItem(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	manager = [_logos_static_class_lookup$SBLockScreenManager() sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	CSAdjunctListItem *item = [vc.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
	return item;
}

static void _logos_method$_ungrouped$CSMediaControlsView$removePlayer(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	CSAdjunctListItem *item = [self getPlayerItem];
	manager = [_logos_static_class_lookup$SBLockScreenManager() sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	if ([[_logos_static_class_lookup$SBMediaController() sharedInstance] isPaused]) {
		[vc _removeItem:(id)item animated:(BOOL)YES];
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification object:nil];
}


static void _logos_method$_ungrouped$CSMediaControlsView$playbackStateChanged(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	CSAdjunctListItem *item = [self getPlayerItem];
	manager = [_logos_static_class_lookup$SBLockScreenManager() sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	[vc _insertItem:(id)item animated:(BOOL)YES];
}
static void _logos_method$_ungrouped$CSMediaControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	manager = [_logos_static_class_lookup$SBLockScreenManager() sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(removePlayer)];
	swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
	[self addGestureRecognizer:swipeleft];
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CSMediaControlsView = objc_getClass("CSMediaControlsView"); { char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(CSAdjunctListItem *), strlen(@encode(CSAdjunctListItem *))); i += strlen(@encode(CSAdjunctListItem *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CSMediaControlsView, @selector(getPlayerItem), (IMP)&_logos_method$_ungrouped$CSMediaControlsView$getPlayerItem, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CSMediaControlsView, @selector(removePlayer), (IMP)&_logos_method$_ungrouped$CSMediaControlsView$removePlayer, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CSMediaControlsView, @selector(playbackStateChanged), (IMP)&_logos_method$_ungrouped$CSMediaControlsView$playbackStateChanged, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CSMediaControlsView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$CSMediaControlsView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$CSMediaControlsView$layoutSubviews);} }
#line 40 "Tweak.x"
