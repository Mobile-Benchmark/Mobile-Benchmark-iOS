//
//  ResultTableViewController.h
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLFetcher.h"
#import "CustomCellHistoryResult.h"

@interface HistoryResultTableViewController : UITableViewController
{
    @private
    URLFetcher *fether;
    NSMutableArray *testList;
    NSMutableArray *scoreList;
	NSString *benchmarkKey;
    UIActivityIndicatorView *activity;
}
@property (copy) NSString *benchmarkKey;

@end
