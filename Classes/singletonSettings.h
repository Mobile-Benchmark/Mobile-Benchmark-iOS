//
//  singletonSettings.h
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singletonSettings : NSObject{
    
    NSInteger scoreHardwareTest;
    NSInteger scoreIOTest;
    NSInteger scoreInternetSpeedTest;
    NSInteger scoreCPUTest;
    NSInteger isTestingAll;
    
    NSInteger totalScore;
    NSInteger submittedScore;
}

+ (singletonSettings *)sharedSingleton;



- (void)setHardwareScore:(NSInteger)score;
- (NSInteger)scoreHardwareTest;

- (NSInteger)IsTestingAll;
- (void)setIsTestingAll:(NSInteger)status;

- (NSInteger)scoreInternetSpeedTest;
- (void)setInternetSpeedTestScore:(NSInteger)score;

- (NSInteger)scoreCPUTest;
- (void)setCPUTestScore:(NSInteger)score;

- (NSInteger)scoreIOTest;
- (void)setIOScore:(NSInteger)score;

- (NSInteger)totalScore;

- (NSInteger)submittedScore;
- (void)setSubmittedScore:(NSInteger)score;
@end
