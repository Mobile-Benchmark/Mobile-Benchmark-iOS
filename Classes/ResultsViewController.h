//
//  ResultsViewController.h
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define IO_STORAGE_TEST_INTERN @"Intern IO Storage"
#define IO_STORAGE_TEST_EXTERN @"Extern IO Storage"
#define CPU_TEST @"CPU Single Thread - PI Calculation"
#define HARDWARE_INFORMATION @"Hardware Information"
#define INTERNET_SPEED_TEST @"Internet speed test"

#import <UIKit/UIKit.h>
#import "singletonSettings.h"
#import "URLFetcher.h"
#import "SBJson.h"

@interface ResultsViewController : UIViewController{
    URLFetcher *urlfetcher;
    
    NSString *scoreHardware;
    NSString *scoreIOTest;
    NSString *scoreCPUTest;
    NSString *scoreInternetTest;
    NSString *scoreTotal;
    
    UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet UILabel *hardwareScore;
@property (nonatomic, retain) IBOutlet UILabel *ioScore;
@property (nonatomic, retain) IBOutlet UILabel *cpuScore;
@property (nonatomic, retain) IBOutlet UILabel *internetSpeedScore;
@property (nonatomic, retain) IBOutlet UILabel *totalScore;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;

- (IBAction)submitScores:(id)sender;

- (void)makeTheJSON;
- (void)loadScores;

@end
