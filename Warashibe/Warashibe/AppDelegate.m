//
//  AppDelegate.m
//  Warashibe
//
//  Created by 彰悟 北村 on 12/07/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "NAVController1.h"
#import "NAVController2.h"
#import "NAVController3.h"

@implementation AppDelegate
@synthesize navc1,navc2,navc3;
@synthesize tabBarController;
@synthesize window = _window;


#pragma mark -init-

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    //TABC
    tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
      
    //NAV1+VC1
    ViewController1 *vc1=[[[ViewController1 alloc] initWithNibName:nil bundle:nil] autorelease];
    navc1=[[NAVController1 alloc] initWithRootViewController:(UIViewController *)vc1];
    [navc1 setNavigationBarHidden:YES];
    
    //NAV2+VC2
    ViewController2 *vc2 = [[[ViewController2 alloc] initWithNibName:nil bundle:nil] autorelease];
    //tab3 =[[ViewController3 alloc] initWithStyle:UITableViewStylePlain];
    navc2=[[NAVController2 alloc] initWithRootViewController:vc2];
    [navc2 setNavigationBarHidden:YES];
    
    //NAV3+VC3
    ViewController3 *vc3=[[[ViewController3 alloc] initWithStyle:UITableViewStylePlain] autorelease];
    navc3=[[NAVController3 alloc] initWithRootViewController:vc3];
    [navc3 setNavigationBarHidden:YES];
    
    UIImage *icon0 = [UIImage imageNamed:@"tabpen.png"];
    UIImage *icon1 = [UIImage imageNamed:@"tab.png"];
    UIImage *icon2 = [UIImage imageNamed:@"TabMigi.png"];

    navc1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"わらしべる" image:icon0 tag:0];
    navc2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"取説" image:icon1 tag:1];
    navc3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"タイムライン" image:icon2 tag:2];

    NSArray *controllers = [NSArray arrayWithObjects:navc1,navc2,navc3,nil];
    [tabBarController setViewControllers:controllers]; 
    [tabBarController setSelectedIndex:1];
    
    
    [self.window addSubview:tabBarController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma  mark -dealloc-

- (void)dealloc
{
    [tabBarController release];
    [navc1 release], navc1=nil;
    [navc2 release], navc2=nil;
    [navc3 release], navc3=nil;
    [_window release];
 
    [super dealloc];
}


@end
