#import "YQAppDelegate.h"
#import "YQRunAndTurnViewController.h"

@implementation YQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    YQRunAndTurnViewController *crViewController = [[YQRunAndTurnViewController alloc] init];
    [self.window addSubview:crViewController.view];

    [self.window makeKeyAndVisible];
    return YES;
}
@end
