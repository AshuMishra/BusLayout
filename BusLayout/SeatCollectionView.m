//
//  SeatCollectionView.m
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatCollectionView.h"
#import "SeatCollectionCell.h"
#import "SeatFlowLayout.h"

@interface SeatCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SeatFlowLayout *flowLayout;

@end

@implementation SeatCollectionView

- (void)awakeFromNib {
	[super awakeFromNib];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	UINib *nib = [UINib nibWithNibName:@"SeatCollectionCell" bundle:[NSBundle mainBundle]];
	[self.collectionView registerClass:[SeatCollectionCell class] forCellWithReuseIdentifier:@"seatCell"];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:@"seatCell"];
	self.flowLayout = [[SeatFlowLayout alloc]init];
	self.flowLayout.interSegmentSpace = 40.0;
	self.collectionView.collectionViewLayout = self.flowLayout;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
	return CGSizeMake(50, type == SeatTypeSleeper ? 75 : 50);
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	NSInteger segments = [self.datasource numberOfSegments];
	NSMutableArray *array = [NSMutableArray array];

	NSInteger sections = 0;
	for (int i = 0; i < segments; i++) {
		NSInteger sectionPerSegment = [self.datasource seatCollectionView:self numberOfSectionsForSegment:i];
		sections += sectionPerSegment;
		for (int j = 0; j < sectionPerSegment; j++) {
			[array addObject:[NSNumber numberWithInteger:i]];
		}
	}
	self.flowLayout.segmentIndexForSection = array;
	[self.flowLayout invalidateLayout];
	return sections;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.datasource maximumNumberOfItemsPerSection];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"seatCell" forIndexPath:indexPath];
//	UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.frame.size.width - 10, cell.frame.size.height-10)];
	NSString *seatName = [self.datasource seatCollectionView:self seatNameforIndexPath:indexPath];
	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
	cell.type = type;
	[cell setType:type status:SeatStatusAvailable];
//	label.text = seatName;
//	[cell.contentView addSubview:label];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = (SeatCollectionCell *)[collectionView cellForItemAtIndexPath: indexPath];
	cell.selected = YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
	return (type == SeatStatusAvailable);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
	return (type == SeatStatusAvailable);
}

@end
