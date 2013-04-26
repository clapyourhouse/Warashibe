
#import "credit_ViewController.h"

@interface credit_ViewController ()

@end

@implementation credit_ViewController

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
    NSString *cBtnTitle;
    cBtnTitle = @"戻る";
    
    
    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cButton setFrame:CGRectMake(220, 320, 90, 60)];
    [cButton setTitle:cBtnTitle forState:UIControlStateNormal];
    [cButton addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cButton];
    
    
    UITextView *credit = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [credit setBackgroundColor:[UIColor whiteColor]];
    [credit setFont:[UIFont italicSystemFontOfSize:20]];
    [credit setText:@"Created By clapyourhouse\nMainCoder Shogo\nSubCoder Yossy"];
    [credit setEditable:NO];
    [self.view addSubview:credit];
    [credit release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    

}

-(void)pushBtn{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
