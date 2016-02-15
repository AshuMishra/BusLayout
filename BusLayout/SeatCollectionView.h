//
//  SeatCollectionView.h
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatCollectionCell.h"

@protocol SeatCollectionViewDatasource;

@interface SeatCollectionView : UIView

@property (nonatomic, assign) id<SeatCollectionViewDatasource> datasource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@protocol SeatCollectionViewDatasource

- (NSInteger)numberOfSegments;
- (NSInteger)seatCollectionView:(SeatCollectionView *)colelctionView numberOfSectionsForSegment:(NSInteger) segment;
- (NSInteger)maximumNumberOfItemsPerSection;

- (SeatType)seatCollectionView:(SeatCollectionView *)colelctionView seatTypeforIndexPath: (NSIndexPath *)indexPath;
- (NSString *)seatCollectionView:(SeatCollectionView *)colelctionView seatNameforIndexPath: (NSIndexPath *)indexPath;

@end
