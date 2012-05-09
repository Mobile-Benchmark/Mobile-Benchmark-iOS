//
//  StateTableCellView.h
//  States
//
//  Created by Julio Barros on 1/26/09.
//  Copyright 2009 E-String Technologies, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCellHistoryResult : UITableViewCell {
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *testLabel;
}

@property (nonatomic,retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic,retain) IBOutlet UILabel *testLabel;

@end
