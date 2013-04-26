#import <Foundation/Foundation.h>

@interface XMLParser : NSObject<NSXMLParserDelegate>

@property (nonatomic, retain)    NSMutableArray * documents;
@property (nonatomic, retain)    NSMutableDictionary * currentItem;
@property (nonatomic, copy )     NSString *currentString;
@property (nonatomic, readwrite) BOOL downloadError;
@property (nonatomic, readwrite) BOOL endOfDocumentReached;

-(void)parseXMLFileAtURL:(NSURL *)URL;
-(BOOL)isDone;
-(NSMutableArray *)parsedItems;

@end