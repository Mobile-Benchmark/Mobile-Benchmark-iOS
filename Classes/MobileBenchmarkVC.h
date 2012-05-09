//
//  MobileBenchmarkVC.h
//  iOSMobileBenchmark
//
//  Created by Lion User on 13/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileBenchmarkVC : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSArray *testList;
    NSArray *extraInfoList;
    UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
