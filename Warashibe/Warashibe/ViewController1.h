
#import <UIKit/UIKit.h>
@class Person;
@interface ViewController1 : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UITextField *titleText;
    UITextField *commentText;
    UIImageView *imageView;
    UIImage *save_image ;
    UITextField *koukanText;
    UILabel *koukanLabel;

    
}

@property(nonatomic,retain)UITextField *titleText;
@property(nonatomic,retain)UITextField *commentText;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UIImage *save_image;
@property(nonatomic,retain)UITextField *koukanText;
@property(nonatomic,retain)UILabel *koukanLabel;


- (BOOL)entryPersonWithName:(NSString*)title:(NSString*)comment:(NSString*)number:(NSString*)koukan;

@end
