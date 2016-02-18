//
//  SeatCollectionCell.h
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SeatType) {
	SeatTypeNone,
	SeatTypeSeater,
	SeatTypeSleeper
};

typedef NS_ENUM(NSInteger, SeatStatus) {
	SeatStatusAvailable,
	SeatStatusLadies,
	SeatStatusBooked,
	SeatStatusNone
};

@interface SeatCollectionCell : UICollectionViewCell

@property (nonatomic, assign) SeatType type;
@property (nonatomic, assign) SeatStatus status;

- (void)setType:(SeatType)type status:(SeatStatus)status name:(NSString *)name;

@end
