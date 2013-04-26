
#import "ViewController1.h"
#import "AppDelegate.h"
#import "Person.h"
#import "CoreDataClass.h"
#import "ViewController3.h"
#import <Twitter/Twitter.h>
@interface ViewController1 (){
    
    
    
}

@end


@implementation ViewController1
@synthesize titleText,commentText,imageView,save_image,koukanText,koukanLabel;


//わらしべるのタブ１
-(id)init{
    if (self = [super init]) {
        self.title =@"わらしべる";
        [self.view setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //これの意味を知りたい。
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
//設定画面のボタン
    NSString *btnTitle;
    btnTitle = @"投稿する";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(220, 330, 80, 60)];
    [button setTitle:btnTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
                        
//タイトル入力テキスト
    titleText = [[UITextField alloc]init];
    [titleText setFrame:CGRectMake(40, 20, 240, 30)];
    [titleText setBorderStyle:UITextBorderStyleRoundedRect];//フィールドの形式。
    [titleText setReturnKeyType:UIReturnKeyDone];
    [titleText setKeyboardType:UIKeyboardTypeDefault];
    [titleText setPlaceholder:@"title"];
    [titleText setClearButtonMode:UITextFieldViewModeAlways];//?
    [titleText addTarget:self action:@selector(exitTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:titleText];
    
    [titleText release];
    
//コメント入力テキスト
    commentText = [[UITextField alloc]init];
    [commentText setFrame:CGRectMake(10, 230, 300, 80)];
    [commentText setKeyboardType:UIKeyboardTypeDefault];
    [commentText setBorderStyle:UITextBorderStyleRoundedRect];
    [commentText setReturnKeyType:UIReturnKeyDone];
    [commentText setPlaceholder:@"comment"];
    [commentText setClearButtonMode:UITextFieldViewModeAlways];
    [commentText addTarget:self action:@selector(exitTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];

    [self.view addSubview:commentText];
    
    [commentText release];
    
//画像が入ります。
    imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(10,60, 300, 160)];
    [imageView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:imageView];
    
    
//透明のボタン。これで画像を出力。撮影。モーダル。
    UIButton *skeltonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skeltonBtn setFrame:CGRectMake(10, 60, 300, 160)];
    //[skeltonBtn setBackgroundColor:[UIColor cyanColor]];
    [skeltonBtn addTarget:self action:@selector(pushButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:skeltonBtn];
    
    
    koukanLabel = [[UILabel alloc]init];
    [koukanLabel setFrame:CGRectMake(10, 320, 80, 80)];
    [koukanLabel setText:@"交換回数"];
    [self.view addSubview:koukanLabel];
    [koukanLabel release];
    
    koukanText = [[UITextField alloc]init];
    [koukanText setFrame:CGRectMake(90, 330, 80, 60)];
    [koukanText setKeyboardType:UIKeyboardTypeDefault];
    [koukanText setBorderStyle:UITextBorderStyleRoundedRect];
    [koukanText setReturnKeyType:UIReturnKeyDone];
    [koukanText setPlaceholder:@"回数"];
    [koukanText setClearButtonMode:UITextFieldViewModeAlways];
    [koukanText addTarget:self action:@selector(exitTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:koukanText];
    [koukanText release];
    
    
    
    //画像アクションシート
    //self.title = @"画像添付";
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(buttonPush)];
    self.navigationItem.rightBarButtonItem =actionButton;
    [actionButton release];
           
}


//画像のアクションシート                
-(void)pushButton{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"カメラ起動",@"ライブラリへ", nil];
    
    [sheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    //[sheet showInView:self.view];
    [sheet showFromTabBar:app.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // ボタンインデックスをチェックする
    if (buttonIndex >= 3) {
        return;
    }
    
    // ソースタイプを決定する
    UIImagePickerControllerSourceType   sourceType = 0;
    switch (buttonIndex) {
        case 0: {
            // カメラ起動
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1: {
            // ライブラリへ
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 2: {
            // キャンセル
            return;
            //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        }
    }
    
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    // イメージピッカー起動
    UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
    picker.sourceType = sourceType;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
}

// ライブラリで選択した画像を持ってくる
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    save_image = image ;
    [imageView setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
}

// キャンセル時
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    
}

-(void)exitTextField:(UITextField*)field{
    NSLog(@"入力完了");
    [field resignFirstResponder];
    
}


#import "CoreDataClass.h"

//coreDataで保存してます。
- (BOOL)entryPersonWithName:(NSString*)title:(NSString*)comment:(NSString*)number:(NSString*)koukan
{
    
    //ImageをNSDataに変換。
    NSData* pngData = [[[NSData alloc]initWithData:UIImagePNGRepresentation(save_image)]autorelease];
   
    //追加(CoreDataClassをシングルトンで作成してその中にmanagedObjectContextを呼び出す）
    CoreDataClass *cdc=[CoreDataClass sharedInstance];

    NSManagedObjectContext *managedObjectContext=cdc.managedObjectContext;
    
    //NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];
    
    Person *person;
    
    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                           inManagedObjectContext:managedObjectContext];
    person.title = title;
    person.comment = comment;
    person.number = number;
    person.koukan = koukan;
    [person setValue:pngData forKey:@"image"];
    
    
    

    NSError *error = nil;
    if(![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return NO;
    }
    
    return YES;
}

//ボタン押したらAlert画面！
//書き込んだ内容が保存されます。
-(void)pushBtn{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"この内容でよろしいですか？"delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
    alert.tag = 1;
    
    [alert show];

    
    //Setting_ViewController *sView =[[[Setting_ViewController alloc]init]autorelease];
    //[self.navigationController pushViewController:sView animated:YES];
    
}
-(void)pushBtn2{
    
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:nil message:@"TwitterもしくはFacebookに投稿しますか？"delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
    alert1.tag = 2;
    
    [alert1 show];
}

//Alert処理の内容。
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tag = alertView.tag;
    
    if( tag == 1 ) {
        // 1個目のアラート
        switch (buttonIndex) {
            case 0:
                [self pushBtn2];
                //coreDataセーブしてます。
                [self entryPersonWithName:titleText.text :commentText.text:koukanText.text:koukanLabel.text];

                
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


- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
