//
//  ResultsViewController.h
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLFetcher.h"
#import "CustomCellHistory.h"

@interface HistoryTableViewController : UITableViewController
{
    @private
    URLFetcher *fether;
    NSMutableArray *scoreList;
    NSMutableArray *datumList;
    UIActivityIndicatorView *activity;

    
    @public
    NSMutableArray *indexToBenchmarkKey;
}
@end
