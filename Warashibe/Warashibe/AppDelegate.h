
#import <UIKit/UIKit.h>

@class NAVController1;
@class NAVController2;
@class NAVController3;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UITabBarController *tabBarController;
    NAVController1 *navc1;
    NAVController2 *navc2;
    NAVController3 *navc3;    

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NAVController1 *navc1;
@property (nonatomic, retain) NAVController2 *navc2;
@property (nonatomic, retain) NAVController3 *navc3;

@end
