//
//  SeatCollectionCell.h
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatModel.h"

@interface SeatCollectionCell : UICollectionViewCell

@property (nonatomic, assign) SeatType type;
//@property (nonatomic, assign) SeatStatus status;
@property (nonatomic, assign) BOOL isAvailable;

- (void)addOverlay:(BOOL)add;
//- (void)setType:(SeatType)type status:(SeatStatus)status name:(NSString *)name;

- (void)configureWithSeat:(SeatModel *)seat;

@end
