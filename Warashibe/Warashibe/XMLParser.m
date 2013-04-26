
#import "XMLParser.h"
@implementation XMLParser
@synthesize currentString;
@synthesize documents;
@synthesize currentItem;
@synthesize downloadError, endOfDocumentReached;

#pragma mark -NSXMLParserDelegateのメソッド
// XMLのパース開始
-(void)parserDidStartDocument:(NSXMLParser *)parser {
    
    //新しい可変長配列を作成
    NSMutableArray * documentsArray = [[NSMutableArray alloc] init];
    //新しいディクショナリを作成する（古いものはリリース）
	self.documents = documentsArray;
	[documentsArray release];
}


//読み込みに失敗した場合
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    //エラーが起きたときにはYESになる
    self.downloadError = YES;
}

// 要素の開始タグを読み込み
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
                                        namespaceURI:(NSString *)namespaceURI 
                                       qualifiedName:(NSString *)qName 
                                          attributes:(NSDictionary *)attributeDict{

    NSMutableDictionary * dictionary = nil;
    
    //開始タグを見つけたら新しいディクショナリーcurrentItemを作成
	if ([elementName isEqualToString:@"data"]) {
		//新しいディクショナリを作成する（古いものはリリース）
		dictionary = [[NSMutableDictionary alloc] init];
		self.currentItem = dictionary;
        [dictionary release];
	}
}

// 要素の閉じタグを読み込み
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                      namespaceURI:(NSString *)namespaceURI 
                                     qualifiedName:(NSString *)qName{
    
    //閉じタグがtitleだった場合
    if ([elementName isEqualToString:@"title"]) {
        //ディクショナリーcurrentItemにcurrentStringをtitleというキーとともに格納
		[self.currentItem setValue:currentString forKey:@"title"];
		
    //閉じタグがlinkだった場合
	} else if ([elementName isEqualToString:@"link"]) {
		//linkというキーとともに格納
		[self.currentItem setValue:currentString forKey:@"link"];
    //閉じタグがthumbだった場合
	} else if ([elementName isEqualToString:@"thumb"]) {
		//thumbというキーとともに格納
		[self.currentItem setValue:currentString forKey:@"thumb"];
		
    //閉じタグがdataだった場合
	} else if ([elementName isEqualToString:@"data"]) {
		//文章全体の可変長配列documentsにcurrentItemを追加する
		[self.documents addObject:currentItem];
	}
}

// テキストデータ読み込み
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //文字データを見つけたら、文字列currentStringに格納
    self.currentString = string;
}

// XMLのパース終了
- (void)parserDidEndDocument:(NSXMLParser *)parser {
 //XML全体のパースが終了した場合、YESにする
    self.endOfDocumentReached = YES;
}

#pragma mark -オリジナルのメソッド
//XMLパーサーの初期化
- (void)parseXMLFileAtURL:(NSURL *)url {
    
    NSXMLParser * xmlParser   = nil;
    NSData * xmlData          = nil;
	    
    self.downloadError        = NO;
    self.endOfDocumentReached = NO;
    
    xmlData = [NSData dataWithContentsOfURL:url];
    xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
	
	[xmlParser setDelegate:self];
	
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
	
    [xmlParser parse]; // パース開始
	[xmlParser release]; //xmlParserを解放
}

//XMLの読み込みが完全に終了したかどうか判別
-(BOOL)isDone {
return ((!self.downloadError)&&(self.endOfDocumentReached)&&(self.documents));
}

//パースされたXMLデータを表示するメソッド
-(NSMutableArray *)parsedItems {
    return self.documents;
}

#pragma mark -NSObjectのメソッド
//メモリーの解放
- (void)dealloc {
	[documents release];
	[currentItem release];
	[currentString release];
    [super dealloc];
}

@end






