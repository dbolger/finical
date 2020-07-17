#import <MediaRemote.h>

@interface PLPlatterCustomContentView : UIView
@end

@interface QRTMediaModuleViewController : UIView
@end

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;
@end


@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
@end

@interface SBMainSwitcherViewController: UIViewController
-(void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
+(id)sharedInstance;
-(id)recentAppLayouts;
@end

@interface SBMediaController : NSObject
+(id)sharedInstance;
-(SBApplication *)nowPlayingApplication;
-(BOOL)isPaused;
-(BOOL)isPlaying;
@end
@interface CSCoverSheetViewControllerBase : UIViewController
@end
@interface CSNotificationAdjunctListViewController : CSCoverSheetViewControllerBase {
NSMutableDictionary* _identifiersToItems;
}
@property (nonatomic,retain) NSMutableDictionary * identifiersToItems;
-(void)_removeItem:(id)arg1 animated:(BOOL)arg2;
-(void)_insertItem:(id)arg1 animated:(BOOL)arg2;
@end 
@interface CSCombinedListViewController : CSCoverSheetViewControllerBase 
-(CSNotificationAdjunctListViewController *)adjunctListViewController; 
@end 
@interface CSPresentationViewController : CSCoverSheetViewControllerBase
@end
@interface CSPageViewController : CSPresentationViewController
@end
@interface CSMainPageContentViewController : CSPageViewController 
-(CSCombinedListViewController *)combinedListViewController; 
@end 
@interface CSCoverSheetViewController : UIViewController 
-(CSMainPageContentViewController *)mainPageContentViewController; 
@end 
@interface SBLockScreenManager : NSObject
+(id)sharedInstance;
-(CSCoverSheetViewController *)coverSheetViewController; 
@end 

@interface CSAdjunctListItemView : UIView
@end

@interface CSAdjunctListItem : NSObject 
@end

@interface CSMediaControlsView : UIView 
@end 
