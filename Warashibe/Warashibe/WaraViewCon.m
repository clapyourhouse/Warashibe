//
//  WaraViewCon.m
//  Warashibe
//
//  Created by 彰悟 北村 on 12/08/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaraViewCon.h"

@interface WaraViewCon ()

@end

@implementation WaraViewCon

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
