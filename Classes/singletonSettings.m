//
//  singletonSettings.m
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "singletonSettings.h"

@implementation singletonSettings





- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (singletonSettings *)sharedSingleton;
{
    static singletonSettings *sharedSingleton;
    
    @synchronized(self)
    {
        if(!sharedSingleton)
            sharedSingleton = [[singletonSettings alloc] init];
        
        return sharedSingleton;
    }
}

- (void)setHardwareScore:(NSInteger)score
{
    @synchronized(self)
    {
        scoreHardwareTest = score;
    }
}

- (NSInteger)scoreHardwareTest
{
    @synchronized(self){
        return scoreHardwareTest;
    }
}

- (void)setIOScore:(NSInteger)score
{
    @synchronized(self)
    {
        scoreIOTest = score;
    }
}

- (NSInteger)scoreIOTest
{
    @synchronized(self){
        return scoreIOTest;
    }
}

- (void)setInternetSpeedTestScore:(NSInteger)score
{
    @synchronized(self)
    {
        scoreInternetSpeedTest = score;
    }
}

- (NSInteger)scoreInternetSpeedTest
{
    @synchronized(self){
        return scoreInternetSpeedTest;
    }
}

- (void)setCPUTestScore:(NSInteger)score
{
    @synchronized(self)
    {
        scoreCPUTest = score;
    }
}

- (NSInteger)scoreCPUTest
{
    @synchronized(self){
        return scoreCPUTest;
    }
}


- (void)setIsTestingAll:(NSInteger)status
{
    @synchronized(self)
    {
        isTestingAll = status;
    }
}


- (NSInteger)IsTestingAll
{
    @synchronized(self){
        return isTestingAll;
    }
}


- (NSInteger)totalScore
{
    @synchronized(self){
        return scoreHardwareTest + scoreIOTest + scoreInternetSpeedTest + scoreCPUTest;
    }
}

- (NSInteger)submittedScore
{
    @synchronized(self){
        return submittedScore;
    }
}

- (void)setSubmittedScore:(NSInteger)score
{
    @synchronized(self)
    {
        submittedScore = score;
    }
}



@end
