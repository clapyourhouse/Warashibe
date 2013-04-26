
#import "ViewController3.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "koukan_ViewController.h"
#import "Person.h"
#import "AppDelegate.h"
#import "CoreDataClass.h"


@interface UIImage (CommonImplement)
- (UIImage *) makeThumbnailOfSize:(CGSize)size;
@end

@implementation UIImage (CommonImplement)
- (UIImage *) makeThumbnailOfSize:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    // draw scaled image into thumbnail context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();        
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil) 
        NSLog(@"could not scale image");
    return newThumbnail;
}

@end


@interface ViewController3 ()
{
    bool isSearch;
}
@end

@implementation ViewController3
@synthesize searchData;
@synthesize fetchRequest;
@synthesize managedObjectContext;
@synthesize result;
@synthesize fetchedResultsController;


- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"%s", __FUNCTION__);
    //self = [super initWithStyle:style];
    if ((self = [super initWithStyle:UITableViewStylePlain]))
    {
        // CoreDataから全データをロード
        [self loadAllPerson];
        
        self.title =@"わらしべタイムライン";
        [self.view setBackgroundColor:[UIColor cyanColor]];
        self.tableView.separatorColor = [UIColor brownColor];
        
        //検索バー
        UISearchBar *searchBar = [[[UISearchBar alloc]init]autorelease];
        [searchBar setFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 0)];
        [searchBar setBarStyle:UIBarStyleBlack];
        [searchBar setTranslucent:YES];
        [searchBar setShowsBookmarkButton:YES];
        [searchBar setDelegate:self];
        [searchBar sizeToFit];
        [searchBar setKeyboardType:UIKeyboardTypeNamePhonePad];
        [searchBar setShowsSearchResultsButton:NO];
        [searchBar setPlaceholder:@"検索ワードを入力して下さい"];
        searchBar.showsCancelButton = YES;
        self.tableView.tableHeaderView = searchBar;
        
        UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        [searchDisplayController setDelegate:self];
        [searchDisplayController setSearchResultsDelegate:self];
        [searchDisplayController setSearchResultsDataSource:self];
        self.tableView.tableHeaderView = searchBar;
    }
    
    
    
    
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"view Will Appear");
    [super viewWillAppear:animated];
    [self loadAllPerson];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    NSLog(@"viweDidLoadが呼ばれたよ");
    [super viewDidLoad];
    
        
    

}

//検索メソッド
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar{
    
    [searchBar resignFirstResponder];
    
}




//曖昧な検索をするメソッド。
-(void)filterContentForSearchText:(NSString*)searchString scope:(NSString*)scope {
    
    NSString *query = self.searchDisplayController.searchBar.text;
    if (query && query.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", query];
        [self.fetchedResultsController.fetchRequest setPredicate:predicate];
        
        [NSFetchedResultsController deleteCacheWithName:@"title"];
    }
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    /*
    
    [searchData removeAllObjects];
    
    
       for(Person *person in result) {
        NSString *text = person.title;
        NSRange range = [text rangeOfString:searchString 
                                     options:NSCaseInsensitiveSearch];
        if(range.length > 0)
            [searchData addObject:person];
    }
     
     
    [self.tableView reloadData];
     */
}
 
 /*

-(BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString {
    [self filterContentForSearchText: searchString
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}
   */                   

//この内容はいるのか？？
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (0 == searchText.length) {
        [result release];
        result = [[NSMutableArray alloc]initWithArray:result];
        [self.tableView reloadData];
        
    }else {
        //
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


#pragma mark - Table view data source


//タブの数。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//タブの大きさ。範囲。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    {
        if(tableView == self.searchDisplayController.searchResultsTableView)
            return searchData.count;
        //return items_.count;
        return [result count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //一回作ったものを再利用している。
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    //セルの情報。
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    //NSError *error = nil;
    //NSArray *result = [self.managedObjectContext executeFetchRequest:self.fetchRequest error:&error];
    //
    
    Person *person;
    if (tableView == self.searchDisplayController.searchResultsTableView){
        person = [searchData objectAtIndex:indexPath.row];
    }else{
        person = [result objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = person.title;
    NSLog(@"person title:%@",person.title);
    cell.detailTextLabel.text = person.comment;
    UIImage *srcImage = [UIImage imageWithData:person.image];
    cell.imageView.image = [srcImage makeThumbnailOfSize:CGSizeMake(80, 100)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    
    
    UILabel *koukankaisuuuuu = [[UILabel alloc]init];
    [koukankaisuuuuu setFrame:CGRectMake(180, 110, 110, 20)];
    //[changeCount setText:@"回"];
    [koukankaisuuuuu setBackgroundColor:[UIColor cyanColor]];
    [koukankaisuuuuu setFont:[UIFont italicSystemFontOfSize:20]];
    [koukankaisuuuuu setText:person.koukan];
  //  cell.textLabel.frame = [ko
    [self.view addSubview:koukankaisuuuuu];
    

    UILabel *changeCount = [[UILabel alloc] init];
    [changeCount setFrame:CGRectMake(280, 110, 100, 20)];
    //[changeCount setText:@"回"];
    [changeCount setBackgroundColor:[UIColor cyanColor]];
    [changeCount setFont:[UIFont italicSystemFontOfSize:20]];
    [changeCount setText:person.number];
    
    [self.view addSubview:changeCount];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *messge = [result objectAtIndex:indexPath.row];
    UIAlertView *alert1 = [[[UIAlertView alloc]init]autorelease];
    //まず、保存されているデータはNSStringのみではないのでalertで持っていこうとすることが無理がある。
    //alert1.message = ;
    
    [alert1 addButtonWithTitle:@"交換のページです。"];
    [alert1 show];
    
    koukan_ViewController *kView = [[koukan_ViewController alloc]init];
    
    [self.navigationController pushViewController:kView animated:YES];


    
}


//coreDataをロード
- (void)loadAllPerson
{
    
    CoreDataClass *cdc=[CoreDataClass sharedInstance];
    managedObjectContext=cdc.managedObjectContext;


   // AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
   // NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];
    
    fetchRequest = [[[NSFetchRequest alloc] init] retain];
    
    NSEntityDescription *personDescription;
    personDescription = [NSEntityDescription entityForName:@"Person"
                                    inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:personDescription];
    
    // 年齢の昇順でソート
    NSSortDescriptor *sortByAge = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortByAge, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // レコードを取得する
    NSError *error = nil;
    result = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] retain];
    if ( error ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    NSLog(@"%d", [result count]);
    
    Person *person;
    for ( int i=0; i<[result count]; i++ ) {
        person = [result objectAtIndex:i];
        NSLog(@"これこれ！title: %@, comment: %@", person.title, person.comment);
    }
    [sortDescriptors release];
    NSLog(@"loadAllPersonを呼んだよ");
}


//coreDataの検索。
- (void)PredicatePerson{
    
    CoreDataClass *cdc=[CoreDataClass sharedInstance];
    managedObjectContext=cdc.managedObjectContext;
    

    fetchRequest = [[[NSFetchRequest alloc] init] retain];
    
    NSEntityDescription *personDescription;
    personDescription = [NSEntityDescription entityForName:@"Person"
                                    inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:personDescription];
    

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person.title = %@"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
      //  NSLog(@"Unresolved error %@",error,[error userInfo]);
    }
    

    
    
}





#pragma mark -dealloc-
-(void)dealloc{
    [result release];
    [super dealloc];
}


#pragma mark - Table view delegate


@end
