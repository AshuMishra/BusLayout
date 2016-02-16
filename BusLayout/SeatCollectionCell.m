//
//  SeatCollectionCell.m
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatCollectionCell.h"

@interface SeatCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SeatCollectionCell

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self setType:self.type status:selected ? SeatStatusBooked : SeatStatusAvailable];
}


- (void)setType:(SeatType)type status:(SeatStatus) status {
	self.imageView.image = [self imageForSeatType:type status:status];
}

- (UIImage *)imageForSeatType:(SeatType)type status:(SeatStatus) status {
	_type = type;
	if(type == SeatTypeSeater) {
		switch (status) {
			case SeatStatusAvailable:
				return [UIImage imageNamed:@"seat-active"];
			case SeatStatusBooked:
				return [UIImage imageNamed:@"seat-inactive"];
			case SeatStatusLadies:
				return [UIImage imageNamed:@"seat-ladies"];
			case SeatStatusSelected:
				return [UIImage imageNamed:@"seat-selected"];
		}

	}else if (type == SeatTypeSleeper) {
		switch (status) {
			case SeatStatusAvailable:
				return [UIImage imageNamed:@"sleeper-active"];
			case SeatStatusBooked:
				return [UIImage imageNamed:@"sleeper-inactive"];
			case SeatStatusLadies:
				return [UIImage imageNamed:@"sleeper-ladies"];
			case SeatStatusSelected:
				return [UIImage imageNamed:@"sleeper-selected"];

		}
	}
		return nil;
}

@end
