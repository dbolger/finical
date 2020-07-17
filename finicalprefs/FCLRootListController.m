#import <Preferences/PSListController.h>
#import <spawn.h>
@interface FCLRootListController : PSListController
@end
@implementation FCLRootListController

-(void)respring {
        pid_t pid;
        const char* args[] = {"sbreload", NULL};
        posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
}
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Finical" target:self];
	}
	return _specifiers;
}
-(void)openDiscord {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/Vg2EYDR"] options:@{} completionHandler:nil];
}
-(void)openTwitterDM {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/messages/compose?recipient_id=974524608949903361&text=%28Please+describe+your+issue+here%29"] options:@{} completionHandler:nil];
}
-(void)openTwitter5px {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/o5pxels"] options:@{} completionHandler:nil];
}
-(void)openPayPal {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/fivepixels"] options:@{} completionHandler:nil];
}
@end
