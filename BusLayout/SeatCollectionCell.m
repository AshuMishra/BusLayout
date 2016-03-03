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
@property (weak, nonatomic) IBOutlet UILabel *seatNameLabel;
@property (strong, nonatomic) SeatModel *seat;
@end

@implementation SeatCollectionCell

- (void)prepareForReuse {
	[super prepareForReuse];
	self.imageView.image = nil;
	self.alpha = 1.0;
	self.seatNameLabel.text = @"";
}

- (void)configureWithSeat:(SeatModel *)seat {
	self.seat = seat;
	if (self.selected) {
		self.imageView.image = [UIImage imageNamed:@"seat-selected"];
	} else {
		self.imageView.image = [self imageForSeat:seat];
	}
//	self.alpha = seat.seat_Ladies && seat.seat_isBooked ? 1 : 1;
	if (self.seat.seat_isBooked && self.seat.seat_Ladies) {
		NSLog(@"both");
	}
	self.seatNameLabel.text = [NSString stringWithFormat:@"%@", self.seat.seat_Name];
	self.userInteractionEnabled = self.seat != nil && self.seat.seat_isBooked == NO;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	if (selected) {
		self.imageView.image = [UIImage imageNamed:@"seat-selected"];
	}else {
		self.imageView.image = [self imageForSeat:self.seat];
	}
}

- (void)addOverlay:(BOOL)add {
	if (self.seat == nil) {
		NSLog(@"nil");
		self.alpha = 1.0;
	} else {
		self.alpha = add ? 1.0 : 0.5;
	}
}

- (UIImage *)imageForSeat:(SeatModel *)seat {
	if(seat.seat_Type == SeatTypeSeater) {
		if(seat.seat_isBooked) {
			return seat.seat_Ladies ? [UIImage imageNamed:@"seat-ladies"] : [UIImage imageNamed:@"seat-inactive"];
		} else {
			return seat.seat_Ladies ? [UIImage imageNamed:@"seat-ladies"] : [UIImage imageNamed:@"seat-active"];
		}

	}else if (seat.seat_Type == SeatTypeSleeper) {
		if(seat.seat_isBooked) {
			return seat.seat_Ladies ? [UIImage imageNamed:@"sleeper-ladies"] : [UIImage imageNamed:@"sleeper-inactive"];
		} else {
			return seat.seat_Ladies ? [UIImage imageNamed:@"sleeper-ladies"] : [UIImage imageNamed:@"sleeper-active"];
		}
	}
	return nil;
}

@end
