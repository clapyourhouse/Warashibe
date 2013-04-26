
#import "ViewController2.h"
#import "credit_ViewController.h"
@interface ViewController2 (){
        
    NSArray *segItems;
}


@end

@implementation ViewController2



-(id)init{
    if (self = [super init]) {
        self.title =@"取説";
        [self.view setBackgroundColor:[UIColor yellowColor]];
    }
    return self;
}

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
    
    
    // セグメントボタン用アイテムs
    segItems = [NSArray arrayWithObjects:@"遊び方", @"趣旨", @"注意事項", nil]; // セグメントボタン作成(アイテムを指定して生成)
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segItems];
    
    // スタイルの変更
    [seg setSegmentedControlStyle:UISegmentedControlStyleBar]; // 起動時に選択しているボタンを設定する(0番スタート)
    [seg setSelectedSegmentIndex:0];
    [seg setCenter:CGPointMake(160, 150)];
    [seg setFrame:CGRectMake(200, 200, 200, 200)];
    // ボタン操作(値変更)時のアクション設定
    [seg addTarget:self action:@selector(changeSegment:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    UIScrollView *sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,170,320,300)];
    sv1.backgroundColor = [UIColor cyanColor];
    
    UITextView *uv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    [uv setBackgroundColor:[UIColor redColor]];
    [uv setFont:[UIFont italicSystemFontOfSize:40]];
    [uv setText:@"遊び方\nまず、下のわらしべるで交換したい物の画像、タイトル、コメント、交換回数を入力します。\n↓"];
    [uv setEditable:NO];
    [sv1 addSubview:uv];
    sv1.contentSize = uv.bounds.size;
    [self.view addSubview:sv1];
    [sv1 release];
    
    UIScrollView *sv2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,250,320,200)];
    sv2.backgroundColor = [UIColor cyanColor];
    
    UITextView *asobi = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [asobi setBackgroundColor:[UIColor blueColor]];
    [asobi setFont:[UIFont italicSystemFontOfSize:40]];
    [asobi setText:@"趣旨\n物交換アプリです。\nあなたのガラクタが交換を繰り返すだけで素晴らしいものになります"];
    [asobi setEditable:NO];
    [sv2 addSubview:asobi];
    sv2.contentSize = asobi.bounds.size;
    [self.view addSubview:sv2];
    [sv2 release];
    
    UIScrollView *sv3 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,330,320,100)];
    sv3.backgroundColor = [UIColor cyanColor];
    
    UITextView *atention = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [atention setBackgroundColor:[UIColor greenColor]];
    [atention setFont:[UIFont italicSystemFontOfSize:40]];
    [atention setText:@"注意事項\n交換は自己責任です。\n↓"];
    [atention setEditable:NO];
    [sv3 addSubview:atention];
    sv3.contentSize = atention.bounds.size;
    [self.view addSubview:sv3];
    [sv3 release];

       
    UILabel *waraTitle =[[UILabel alloc]init];
    [waraTitle setFrame:CGRectMake(20, 30, 280, 100)];
    [waraTitle setBackgroundColor:[UIColor whiteColor]];
    [waraTitle setFont:[UIFont italicSystemFontOfSize:40]];
    [waraTitle setTextColor:[UIColor lightGrayColor]];
    [waraTitle setTextAlignment:UITextAlignmentCenter];
    [waraTitle setText:@"わらしべルール"];
    [self.view addSubview:waraTitle];
    [waraTitle release];

    //クレジット画面へのボタン。
    NSString *btnCTitle;
    btnCTitle =@"Credit";
    UIButton *btnCredit = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [btnCredit setFrame:CGRectMake(250, 10, 50, 50)];
   // [btnCredit setTitle:@"Credit" forState:UIControlStateNormal];
    [btnCredit addTarget:self action:@selector(pushbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCredit];
    
}   


- (void)changeSegment:(UISegmentedControl*)sender{
    
    
    if (sender.selectedSegmentIndex == 0) {
        UIScrollView *sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,170,320,300)];
        sv1.backgroundColor = [UIColor cyanColor];
        
        UITextView *uv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        [uv setBackgroundColor:[UIColor redColor]];
        [uv setFont:[UIFont italicSystemFontOfSize:40]];
        [uv setText:@"遊び方\nまず、下のわらしべるで交換したい物の画像、タイトル、コメント、交換回数を入力して投稿します。\n↓\nその内容が、下のタイムラインに表示されます。他のユーザーがそれに対してわらしべ物を提示しますので、あなたがそれに価値があると思えば1回目の交換成立です。\n↓\nあなたが提示したものは他のユーザー(Aさん)の物となり、他のユーザー(Aさん)が提示した物が次のわらしべ物となります。この物に対して他のユーザー(Bさん)がわらしべ物を提示しAさんがそれに価値があると思えば交換成立です。\nここでの判断権はAさんが持っています。\n↓\nこの流れをあなたが提示した交換回数分繰り返し、その回数に達したときわらしべ物はあなたに返ってきます。何になって返ってくるかわからないギャンブル性のあるゲームです。\n↓"];
        [uv setEditable:NO];
        [sv1 addSubview:uv];
        sv1.contentSize = uv.bounds.size;
        [self.view addSubview:sv1];
        [sv1 release];
    }else if(sender.selectedSegmentIndex == 1){
        UIScrollView *sv2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,250,320,200)];
        sv2.backgroundColor = [UIColor cyanColor];
        
        UITextView *asobi = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [asobi setBackgroundColor:[UIColor blueColor]];
        [asobi setFont:[UIFont italicSystemFontOfSize:40]];
        [asobi setText:@"趣旨\n物交換アプリです。\nあなたのガラクタが交換を繰り返すだけで素晴らしいものになります。しかし、何になるかはわかりません。ギャンブルです。あなたのものをわらしべ物にしてみませんか？"];
        [asobi setEditable:NO];
        [sv2 addSubview:asobi];
        sv2.contentSize = asobi.bounds.size;
        [self.view addSubview:sv2];
        [sv2 release];
    }else if(sender.selectedSegmentIndex == 2){
        UIScrollView *sv3 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,330,320,100)];
        sv3.backgroundColor = [UIColor cyanColor];
        
        UITextView *atention = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [atention setBackgroundColor:[UIColor greenColor]];
        [atention setFont:[UIFont italicSystemFontOfSize:40]];
        [atention setText:@"注意事項\n交換は自己責任です。このアプリを使用して起きた際に起きたトラブルの責任はいっさい負いかねます。\n↓"];
        [atention setEditable:NO];
        [sv3 addSubview:atention];
        sv3.contentSize = atention.bounds.size;
        [self.view addSubview:sv3];
        [sv3 release];

    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

-(void)pushbtn{
    credit_ViewController *cBtn = [[[credit_ViewController alloc]init]autorelease];
    [self presentModalViewController:cBtn animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
