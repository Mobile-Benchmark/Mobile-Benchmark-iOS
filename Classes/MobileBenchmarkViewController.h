//
//  MobileBenchmarkViewController.h
//  MobileBenchmark
//
//  Created by Lion User on 26/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "HardwareTestController.h"
#import "InternetSpeedTestController.h"
#import "singletonSettings.h"
#import "URLFetcher.h"
#import "HistoryTableViewController.h"
#import "ResultsViewController.h"
#import "CPUTestController.h"
#import "IOSpeedTestController.h"

@interface MobileBenchmarkViewController : UIViewController<UITabBarControllerDelegate,UITabBarDelegate>
{
    UIWindow *window;

}

- (IBAction)doBenchmarkAll:(id)sender;
- (IBAction)doHardwareBenchmark:(id)sender;
- (IBAction)doInternetSpeedBenchmark:(id)sender;
- (IBAction)doCPUTestBenchmark:(id)sender;
- (IBAction)dogetResults:(id)sender;
- (IBAction)dogetHistory:(id)sender;
- (IBAction)doIOSpeedTestBenchmark:(id)sender;

@end
