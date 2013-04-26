#import "Setting_ViewController.h"
#import <Twitter/Twitter.h>

@interface Setting_ViewController ()

@end

@implementation Setting_ViewController

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
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    UIButton *sButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sButton setFrame:CGRectMake(220, 320, 90, 60)];
    [sButton setTitle:sBtnTitle forState:UIControlStateNormal];
    [sButton addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sButton];
    
//これでいいですか？の確認ボタン。
    UIButton *kBtnTitle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [kBtnTitle setTitle:@"決定" forState:UIControlStateNormal];
    [kBtnTitle setFrame:CGRectMake(10, 320, 90, 60)];
    [kBtnTitle addTarget:self action:@selector(buttonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kBtnTitle];
    
    
//設定のラベル    
    UILabel *sLabel = [[UILabel alloc]init];
    [sLabel setFrame:CGRectMake(100, 20, 120, 90)];
    [sLabel setBackgroundColor:[UIColor whiteColor]];
    [sLabel setTextColor:[UIColor greenColor]];
    [sLabel setFont:[UIFont systemFontOfSize:20]];
    [sLabel setTextAlignment:UITextAlignmentCenter];
    [sLabel setText:@"設定画面"];
    [self.view addSubview:sLabel];
    [sLabel release];
    
   
    
    /*
     setting_picker = [[[UIPickerView alloc]init]autorelease];
     [setting_picker setDelegate:self];
     [setting_picker setDataSource:self];
     
     CGAffineTransform t0 = CGAffineTransformMakeTranslation(setting_picker.bounds.size.width/2, setting_picker.bounds.size.height/2);
     CGAffineTransform s0 = CGAffineTransformMakeScale(1.0, 1.0);
     CGAffineTransform t1 = CGAffineTransformMakeTranslation(-setting_picker.bounds.size.width/2,
     -setting_picker.bounds.size.height/2);
     setting_picker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
     //[setting_picker setClearsContextBeforeDrawing:YES];
     
     [setting_picker setFrame:CGRectMake(30, 280, 200, 20)];
     [self.view addSubview:setting_picker];
     */
    

    picker = [[[UIPickerView alloc]init]autorelease];
    [picker setDelegate:self];
    [picker setDataSource:self];
    
    [picker setFrame:CGRectMake(0, 130, 320, 100)];
    [self.view addSubview:picker];
}


//UIPickerViewの細かな設定。メソッド。
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ( component == 0 ) {
        return 1;
    }
    return 10;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if ( component == 0 ) {
        return @"交換回数";
    }else {
        return [NSString stringWithFormat:@"%d", row];
    }
    
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (0 == component) {
        return 100;
    }else {
        return 50;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    if (0 == component) {
        return 20;
    }else {
        return 30;
    }
}
//ボタン押したら内容確認。
-(void)buttonDidPush{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"この内容でよろしいですか？"delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
    alert.tag = 1;
    
    [alert show];
}



-(void)buttonDidPush2{
    
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:nil message:@"TwitterもしくはFacebookに投稿しますか？"delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
    alert1.tag = 2;
    
    [alert1 show];
}


//twitter投稿？
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tag = alertView.tag;
    
    if( tag == 1 ) {
        // 1個目のアラート
        switch (buttonIndex) {
            case 0:
                [self buttonDidPush2];
                
                // データ保存
            /*    
            {
                    
                    int data1 = [picker selectedRowInComponent:0];  // 左側の選択番号
                    int data2 = [picker selectedRowInComponent:1];  // 右側の選択番号
                    if ( data1 == 0 ) {
                        // 「交換回数」を洗濯中
                        NSLog(@"0 : 交換回数");
                    }
                    // data2はそのまま数値として使う
                    NSLog(@"1 : %d", data2);
                }
                     */
                break;
            case 1:
                break;
        }
    }else if( tag == 2 ) {
        // 2個目のアラート
        switch (buttonIndex) {
            case 0:
                if ([TWTweetComposeViewController canSendTweet]) {
                    TWTweetComposeViewController *composeViewController = [[TWTweetComposeViewController alloc]init];
                    [composeViewController setInitialText:@"みんなも交換しよう！#Warashibe"];
                    [self presentModalViewController:composeViewController animated:YES];
                }
                break;
            case 1:
                break;
        }
    }
    
}






//ボタン押したらモーダルで、わらしべるタブに戻ります。
-(void)pushBtn{
    
    [self.navigationController popViewControllerAnimated:YES];

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
