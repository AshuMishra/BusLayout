//
//  Seat.m
//  BusLayout
//
//  Created by Susmita Horrow on 16/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatModel.h"
#import "SeatCollectionCell.h"

@implementation SeatModel

+ (NSArray *)seatsFromArray:(NSArray *)seatInfo {
	__block NSMutableArray *seats = [NSMutableArray array];
	[seatInfo enumerateObjectsUsingBlock:^(NSDictionary *seatDict, NSUInteger idx, BOOL *  stop) {
		SeatModel *seat = [SeatModel new];
		
        seat.seat_Row = [[seatDict objectForKey:@"RowNo"] integerValue];
		seat.seat_Column= [[seatDict objectForKey:@"ColumnNo"] integerValue];
		seat.seat_Deck = [[seatDict objectForKey:@"Deck"] integerValue];
        seat.seat_Height = [[seatDict objectForKey:@"Height"]integerValue];
		
        seat.seat_Width = [[seatDict objectForKey:@"Width"]integerValue];
        seat.seat_Name = [seatDict objectForKey:@"SeatName"];
        seat.seat_Type = [self seatTypeForString:[seatDict objectForKey:@"SeatType"]];
        
        seat.seat_Fare = [[seatDict objectForKey:@"SeatFare"]floatValue];
        seat.seat_Ladies = [[seatDict objectForKey:@"LSeat"]boolValue];
        seat.seat_RowType = [seatDict objectForKey:@"row_type"];
        seat.seat_ServiceTax = [[seatDict objectForKey:@"ServiceTax"]floatValue];
//		NSString *statusString = [seatDict objectForKey:@"seat_status"];
		seat.seat_Status = [[seatDict objectForKey:@"SeatStatus"]integerValue];
		[seats addObject:seat];
	}];
	return seats;
}

+ (SeatType)seatTypeForString:(NSString *) type {
	if ([type isEqualToString:@"Seater"]) return SeatTypeSeater;
	else if ([type isEqualToString:@"Sleeper"]) return SeatTypeSleeper;
	else return SeatTypeNone;
}

- (SeatStatus)seatStatus {
	if(self.seat_Ladies == YES) {
		return SeatStatusLadies;
	}else if (self.seat_Status == 1) {
		return SeatStatusAvailable;
	}else {
		return SeatStatusBooked;
	}
}


@end
