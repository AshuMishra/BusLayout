//
//  Seat.h
//  BusLayout
//
//  Created by Susmita Horrow on 16/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeatCollectionView.h"


@interface SeatModel : NSObject

@property(nonatomic, assign) NSInteger seat_Row;
@property(nonatomic, assign) NSInteger seat_Column;
@property(nonatomic, assign) NSInteger seat_Deck;
@property(nonatomic, assign) NSInteger seat_Height;      

@property(nonatomic, assign) NSInteger seat_Width;
@property(nonatomic, assign) NSString *seat_Name;
@property(nonatomic, assign) NSInteger seat_Status;
@property(nonatomic, assign) SeatType seat_Type;

@property(nonatomic, assign) BOOL seat_Ladies;
@property (nonatomic, assign) float seat_Fare;
@property (nonatomic, assign) NSString *seat_RowType;
@property (nonatomic, assign) float seat_ServiceTax;

+ (NSArray *)seatsFromArray:(NSArray *)seatInfo;
- (SeatStatus)seatStatus;
@end
