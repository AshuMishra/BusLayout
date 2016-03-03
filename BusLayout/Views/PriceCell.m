//
//  PriceCell.m
//  BusLayout
//
//  Created by Susmita Horrow on 14/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "PriceCell.h"

@implementation PriceCell

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	self.backgroundColor = selected ? [UIColor redColor] : [UIColor grayColor];
}

@end
