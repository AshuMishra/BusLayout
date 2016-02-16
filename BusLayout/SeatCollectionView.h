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
@property (strong, nonatomic)  UICollectionView *collectionView;

- (void)reloadSeatCollectionView;

@end

@protocol SeatCollectionViewDatasource

- (NSInteger)numberOfSegments;
- (NSInteger)seatCollectionView:(SeatCollectionView *)collectionView numberOfSectionsForSegment:(NSInteger) segment;
- (NSInteger)maximumNumberOfItemsPerSection;

- (SeatType)seatCollectionView:(SeatCollectionView *)collectionView seatTypeforIndexPath: (NSIndexPath *)indexPath;
- (NSString *)seatCollectionView:(SeatCollectionView *)collectionView seatNameforIndexPath: (NSIndexPath *)indexPath;

@end
