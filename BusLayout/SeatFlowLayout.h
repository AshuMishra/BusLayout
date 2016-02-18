//
//  AppDelegate.m
//  CustomCalendar
//
//  Created by Susmita Horrow on 31/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SeatFillType) {
	SeatFillTypeRight,
	SeatFillTypeLeft,
};

@interface SeatFlowLayout : UICollectionViewFlowLayout

@property(nonatomic, assign) SeatFillType fillType;

@end

