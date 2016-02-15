//
//  ViewController.m
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatLayoutController.h"
#import "PriceCell.h"

@interface SeatLayoutController()<SeatCollectionViewDatasource> {
	NSMutableArray * priceArray;
}
@end

@implementation SeatLayoutController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.seatCollectionView.datasource = self;
	priceArray = [NSMutableArray arrayWithObjects:@"All", @"200", @"400", @"600", @"800", nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSegments {
	return 2;
}

- (NSInteger)seatCollectionView:(SeatCollectionView *)colelctionView numberOfSectionsForSegment:(NSInteger) segment {
	switch (segment) {
		case 0:
			return 2;
			break;
			
		case 1:
			return 3;
			break;

  		default:
			return 0;
			break;
	}
}

- (SeatType)seatCollectionView:(SeatCollectionView *)colelctionView seatTypeforIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
  	case 0:
			return SeatTypeSleeper;
		case 1:
			return SeatTypeSeater;
		case 2:
			if (indexPath.item == 0) {
				return SeatTypeSleeper;
			}else {
				return SeatTypeSeater;
			}
		case 3:
			return SeatTypeSleeper;
		case 4:
			return SeatTypeSleeper;

  default:
			return SeatTypeNone;
		}
}

- (NSString *)seatCollectionView:(SeatCollectionView *)colelctionView seatNameforIndexPath:(NSIndexPath *)indexPath {
	return [NSString stringWithFormat:@"%lu", (long)indexPath.row];
}

- (NSInteger)maximumNumberOfItemsPerSection {
	return 5;
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return priceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	PriceCell *priceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"priceCell" forIndexPath:indexPath];
	priceCell.priceLabel.text = [priceArray objectAtIndex:indexPath.row];

	if ([[priceArray objectAtIndex:indexPath.row] isEqualToString:@"All"]) {
		priceCell.backgroundColor = [UIColor redColor];
	}
	else {
        priceCell.backgroundColor = [UIColor lightGrayColor];
	}
	priceCell.priceLabel.textColor = [UIColor whiteColor];
	priceCell.layer.cornerRadius = priceCell.frame.size.width/2;
	priceCell.layer.masksToBounds = YES;
	return priceCell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//	CGSize size = CGSizeMake(40, 40);
//	return  size;
//}

-(void)collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	NSInteger cellCount = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
	if( cellCount >0 )
	{
		CGFloat cellWidth = ((UICollectionViewFlowLayout*)collectionViewLayout).itemSize.width+((UICollectionViewFlowLayout*)collectionViewLayout).minimumInteritemSpacing;
		CGFloat totalCellWidth = cellWidth*cellCount;
		CGFloat contentWidth = collectionView.frame.size.width-collectionView.contentInset.left-collectionView.contentInset.right;
		if( totalCellWidth<contentWidth )
		{
			CGFloat padding = (contentWidth - totalCellWidth) / 2.0;
			return UIEdgeInsetsMake(5, padding, 0, padding);
		}
	}
	return UIEdgeInsetsZero;
}
@end
