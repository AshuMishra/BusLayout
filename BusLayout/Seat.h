//
//  Seat.h
//  BusLayout
//
//  Created by Susmita Horrow on 16/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Seat : NSObject

@property(nonatomic, assign) NSInteger rowNumber;
@property(nonatomic, assign) NSInteger columnNumber;
@property(nonatomic, assign) NSInteger deckNumber;
@property(nonatomic, assign) NSString *seatName;
//@property(nonatomic, assign) NSInteger SeatStatus;
@property(nonatomic, assign) NSString *seatType;
@property(nonatomic, assign) NSString *seatStatus;
@property(nonatomic, assign) NSString *seatFare;

+ (NSArray *)seatsFromArray:(NSArray *)seatInfo;
@end
