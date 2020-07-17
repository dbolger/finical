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
%hook CSMediaControlsView 
CSAdjunctListItem *item;
SBLockScreenManager *manager;
CSNotificationAdjunctListViewController *vc;
NSTimer *timer;
SBMainSwitcherViewController *mainSwitcher;
NSString *nowPlayingID;
NSArray *items;
%new
+(void)removePlayer {
	if ([[%c(SBMediaController) sharedInstance] isPaused]) {
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
%new
+(void)stateChanged:(NSNotification *)notification {
	if ([[%c(SBMediaController) sharedInstance] isPlaying]) {
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
					target: %c(CSMediaControlsView)
					selector: @selector(removePlayer)
					userInfo: nil
					repeats: NO];
			}
		}
	}
}
-(void)layoutSubviews {
	reloadSettings();
	manager = [%c(SBLockScreenManager) sharedInstance];
	vc = [[[[manager coverSheetViewController] mainPageContentViewController] combinedListViewController] adjunctListViewController];
	item = [vc.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
	mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
	items = mainSwitcher.recentAppLayouts;
	nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:%c(CSMediaControlsView) action:@selector(removePlayer)];
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
	%orig;
}
%end
%hook CSAdjunctListItemView
-(void)layoutSubviews {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:%c(CSMediaControlsView)  action:@selector(removePlayer)];
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
	%orig;
}
%end
%hook QRTMediaModuleViewController
-(void)layoutSubviews {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:%c(CSMediaControlsView)  action:@selector(removePlayer)];
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
	%orig;
}
%end
%hook PLPlatterCustomContentView
-(void)layoutSubviews {
	UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:%c(CSMediaControlsView)  action:@selector(removePlayer)];
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
	%orig;
}
%end
%ctor {
	reloadSettings();
	[[NSNotificationCenter defaultCenter] addObserver:%c(CSMediaControlsView) selector:@selector(stateChanged:) name:@"SBMediaNowPlayingChangedNotification" object:nil];
}

