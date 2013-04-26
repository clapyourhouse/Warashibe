//
//  Warashibe.h
//  Warashibe
//
//  Created by 彰悟 北村 on 12/08/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Warashibe : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSData * image;

@end
