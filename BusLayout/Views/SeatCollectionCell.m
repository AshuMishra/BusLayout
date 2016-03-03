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
	self.imageView.image = [self imageForSeat:seat];
	self.seatNameLabel.text = [NSString stringWithFormat:@"%@", self.seat.seat_Name];
	self.userInteractionEnabled = self.seat != nil && self.seat.seat_isBooked == NO;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self configureWithSeat:self.seat];
}

- (void)addOverlay:(BOOL)add {
	if (self.seat == nil) {
		self.alpha = 1.0;
	} else {
		self.alpha = add ? 1.0 : 0.5;
	}
}

- (UIImage *)imageForSeat:(SeatModel *)seat {
	if(seat.seat_Type == SeatTypeSeater) {
		if(self.selected) {
			return [UIImage imageNamed:@"seat-selected"];
		} else if(seat.seat_isBooked) {
			return seat.seat_Ladies ? [UIImage imageNamed:@"seat-ladies-inactive"] : [UIImage imageNamed:@"seat-inactive"];
		} else {
			return seat.seat_Ladies ? [UIImage imageNamed:@"seat-ladies"] : [UIImage imageNamed:@"seat-active"];
		}

	}else if (seat.seat_Type == SeatTypeSleeper) {
		if(self.selected) {
			return [UIImage imageNamed:@"sleeper-selected"];
		} else if(seat.seat_isBooked) {
			return seat.seat_Ladies ? [UIImage imageNamed:@"sleeper-ladies-inactive"] : [UIImage imageNamed:@"sleeper-inactive"];
		} else {
			return seat.seat_Ladies ? [UIImage imageNamed:@"sleeper-ladies"] : [UIImage imageNamed:@"sleeper-active"];
		}
	}
	return nil;
}

@end
