//
//  SeatCollectionView.h
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatCollectionCell.h"
#import "SeatModel.h"

@protocol SeatCollectionViewDatasource;

@interface SeatCollectionView : UIView

@property (nonatomic, assign) id<SeatCollectionViewDatasource> datasource;
@property (strong, nonatomic)  UICollectionView *collectionView;

- (void)reloadSeatCollectionViewWithHeader:(BOOL)showHeader;
- (NSArray *)selectedIndexPaths;

@end

@protocol SeatCollectionViewDatasource

- (NSInteger)numberOfSections;
- (NSInteger)maximumNumberOfItemsPerSection;

- (SeatType)seatCollectionView:(SeatCollectionView *)collectionView seatTypeforIndexPath: (NSIndexPath *)indexPath;
- (SeatStatus)seatCollectionView:(SeatCollectionView *)collectionView seatStatusforIndexPath: (NSIndexPath *)indexPath;
- (NSString *)seatCollectionView:(SeatCollectionView *)collectionView seatNameforIndexPath: (NSIndexPath *)indexPath;
- (BOOL)seatCollectionView:(SeatCollectionView *)collectionView shouldSelectIndexPath: (NSIndexPath *)indexPath;
- (void)seatCollectionView:(SeatCollectionView *)collectionView didSelectIndexPath: (NSIndexPath *)indexPath;
- (void)seatCollectionView:(SeatCollectionView *)collectionView didDeselectIndexPath: (NSIndexPath *)indexPath;
- (BOOL)seatCollectionView:(SeatCollectionView *)collectionView shouldHighlightIndexPath: (NSIndexPath *)indexPath;

@end

