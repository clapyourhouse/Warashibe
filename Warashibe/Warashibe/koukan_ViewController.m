
#import "koukan_ViewController.h"

@interface koukan_ViewController ()

@end

@implementation koukan_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //わらしべるタブに戻るボタン。
    NSString *sBtnTitle;
    sBtnTitle = @"戻る";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *sButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sButton setFrame:CGRectMake(220, 320, 90, 60)];
    [sButton setTitle:sBtnTitle forState:UIControlStateNormal];
    [sButton addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sButton];
}

//ボタン押したらモーダルで、わらしべるタブに戻ります。
-(void)pushBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
