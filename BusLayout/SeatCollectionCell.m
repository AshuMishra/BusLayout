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
@end

@implementation SeatCollectionCell

- (void)prepareForReuse {
	[super prepareForReuse];
	self.imageView.image = nil;
	self.alpha = 1.0;
	self.seatNameLabel.text = @"";
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	if (selected) {
		self.imageView.image = [UIImage imageNamed:@"seat-selected"];
	}else {
		self.imageView.image = [self imageForSeatType:self.type status:self.status];
	}
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	if (self.type == SeatStatusNone) {
		self.alpha = 1.0;
	}else {
		self.alpha = highlighted ? 1.0 : 0.5;
	}
}

- (void)setType:(SeatType)type status:(SeatStatus)status name:(NSString *)name {
	_type = type;
	_status = status;
	if (self.selected) {
		self.imageView.image = [UIImage imageNamed:@"seat-selected"];
	}else {
		self.imageView.image = [self imageForSeatType:self.type status:self.status];
	}
//	self.seatNameLabel.text = name;
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
			case SeatStatusNone:
				return nil;
		}

	}else if (type == SeatTypeSleeper) {
		switch (status) {
			case SeatStatusAvailable:
				return [UIImage imageNamed:@"sleeper-active"];
			case SeatStatusBooked:
				return [UIImage imageNamed:@"sleeper-inactive"];
			case SeatStatusLadies:
				return [UIImage imageNamed:@"sleeper-ladies"];
			case SeatStatusNone:
				return nil;

		}
	}
		return nil;
}

@end
