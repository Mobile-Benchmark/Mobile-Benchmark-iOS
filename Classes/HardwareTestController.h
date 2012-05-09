//
//  HardwareTestController.h
//  MobileBenchmark
//
//  Created by Lion User on 27/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define __IPHONE_2_0 20000
#define __IPHONE_2_1 20100
#define __IPHONE_2_2 20200
#define __IPHONE_3_0 30000
#define __IPHONE_3_1 30100
#define __IPHONE_3_2 30200
#define __IPHONE_4_0 40000

#import <UIKit/UIKit.h>
#import "singletonSettings.h"
#import "CPUTestController.h"


@interface HardwareTestController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIProgressView *threadProgressView;
}


- (void)        getHardwareVersion;

@property (nonatomic, retain) UIProgressView *threadProgressView;

@property (nonatomic, retain) IBOutlet UITableView *tableView;


@end
