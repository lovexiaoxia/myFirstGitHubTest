//
//  AppDelegate.m
//  FuncTarget
//
//  Created by 程昂 on 2017/3/7.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "InhourseMainController.h"
#import "mainControllerDisplayModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define kApplication [UIApplication sharedApplication]

- (void)initRootWindow{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
#if CURRENT_TARGET_APPSTORE
    
    NSDictionary *dic = @{   @"titleString":@"对外版",
                          @"btnTitleString":@"发送通知",
                             @"dicInfo":@{
                                        @"name":@"哈哈",
                                    @"function":@"嗯嗯"
                                     }
                          };
    mainControllerDisplayModel *model = [[mainControllerDisplayModel alloc] initWithJson:dic];
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.model = model;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    _window.rootViewController = navVC;
    
#else
    
    NSDictionary *dic = @{   @"titleString":@"内测版",
                          @"btnTitleString":@"发送通知",
                                 @"dicInfo":@{
                                            @"name":@"哈哈",
                                        @"function":@"嗯嗯"
                                     }
                             };
    mainControllerDisplayModel *model = [[mainControllerDisplayModel alloc] initWithJson:dic];
    
    InhourseMainController *mainVC = [[InhourseMainController alloc] init];
    mainVC.model = model;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    _window.rootViewController = navVC;
#endif
    
    [_window makeKeyAndVisible];
}

- (void)registerLocalNotification{
    
    UIUserNotificationType noteficationType = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *noteSettings = [UIUserNotificationSettings settingsForTypes:noteficationType categories:nil];
    [kApplication registerUserNotificationSettings:noteSettings];
    
    NSDate *date = [NSDate date];
    date = [NSDate dateWithTimeIntervalSinceNow:10];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertTitle = @"哈哈";
    notification.alertBody = @"你给我回来";
    notification.userInfo = @{@"userName":@"heihei"};
    notification.applicationIconBadgeNumber = 2;
    [kApplication scheduleLocalNotification:notification];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initRootWindow];
    [self registerLocalNotification];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -NotificationProcess

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSDictionary *userDic = notification.userInfo;
    if ([userDic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@",userDic);
    }
}


@end
