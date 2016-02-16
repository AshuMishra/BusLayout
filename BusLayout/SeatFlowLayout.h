//
//  AppDelegate.m
//  CustomCalendar
//
//  Created by Susmita Horrow on 31/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SeatFlowLayoutDelegate;

@interface SeatFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSArray *segmentIndexForSection;
@property (nonatomic, assign) CGFloat interSegmentSpace;

@end

