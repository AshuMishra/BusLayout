//
//  Seat.m
//  BusLayout
//
//  Created by Susmita Horrow on 16/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "Seat.h"
#import "SeatCollectionCell.h"

@implementation Seat

+(NSArray *)seatsFromArray:(NSArray *)seatInfo {
	__block NSMutableArray *seats = [NSMutableArray array];
	[seatInfo enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
		Seat *seat = [Seat new];
		seat.rowNumber = [[obj objectForKey:@"RowNo"] integerValue];
		seat.columnNumber = [[obj objectForKey:@"ColumnNo"] integerValue];
		seat.deckNumber = [[obj objectForKey:@"Deck"] integerValue];
		seat.seatName = [obj objectForKey:@"SeatName"];
		seat.seatFare = [obj objectForKey:@"SeatFare"];
//		seat.seatType = [Seat seatTypeForString:[obj objectForKey:@"SeatType"]];
//		seat.seatStatus;
		[seats addObject:seat];
	}];

	return seats;
}

+ (SeatType)seatTypeForString:(NSString *) type {
	if ([type isEqualToString:@"Seater"]) return SeatTypeSeater;
	else if ([type isEqualToString:@"Sleeper"]) return SeatTypeSleeper;
	else return SeatTypeNone;
}



@end
