//
//  StateTableCellView.m
//  States
//
//  Created by Julio Barros on 1/26/09.
//  Copyright 2009 E-String Technologies, Inc.. All rights reserved.
//

#import "CustomCellHistory.h"


@implementation CustomCellHistory

@synthesize dateLabel;
@synthesize scoreLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
