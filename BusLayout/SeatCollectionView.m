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

@interface SeatCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
	NSMutableArray *selectedArray;
}

@property (nonatomic, strong) SeatFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation SeatCollectionView

- (void)awakeFromNib {
	[super awakeFromNib];
	selectedArray = [NSMutableArray array];
	self.flowLayout = [[SeatFlowLayout alloc]init];
	self.collectionView.collectionViewLayout = self.flowLayout;
	self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:self.flowLayout];

	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;

	[self addSubview:self.collectionView];
	self.collectionView.allowsSelection = YES;
	self.collectionView.allowsMultipleSelection = YES;
	self.collectionView.backgroundColor = [UIColor whiteColor];

	UINib *nib = [UINib nibWithNibName:@"SeatCollectionCell" bundle:[NSBundle mainBundle]];
	[self.collectionView registerClass:[SeatCollectionCell class] forCellWithReuseIdentifier:@"seatCell"];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:@"seatCell"];
	[self.flowLayout registerNib:[UINib nibWithNibName:@"DriverSeatView" bundle:nil] forDecorationViewOfKind:@"DriverSeatView"];
}

- (NSArray *)selectedIndexPaths {
	return selectedArray;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *prevIndexPath ;
	if (indexPath.item != 0){
		prevIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
	}
	if (prevIndexPath!= nil) {
		SeatModel *seat = [self.datasource seatCollectionView:self seatForIndexPath:prevIndexPath];
		SeatType prevType = seat.seat_Type;
		if (prevType == SeatTypeSleeper) {
			return CGSizeZero;
		}
		else {
			SeatModel *seat = [self.datasource seatCollectionView:self seatForIndexPath:indexPath];
			return CGSizeMake(50, seat.seat_Type == SeatTypeSleeper ? 100 : 50);
		}
	}
	else {
		SeatModel *seat = [self.datasource seatCollectionView:self seatForIndexPath:indexPath];
		return CGSizeMake(50, seat.seat_Type == SeatTypeSleeper ? 100 : 50);
	}

}


- (void)reloadSeatCollectionViewWithHeader:(BOOL)showHeader {
	self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
	[self.collectionView.collectionViewLayout invalidateLayout];
	if(showHeader) {
		if(![self.subviews containsObject:self.headerView]) {
			self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"DriverSeatView" owner:self options:nil]firstObject];
			[self.collectionView addSubview: self.headerView];
		}

		self.collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
		self.headerView.frame = CGRectMake(0, -40, CGRectGetWidth(self.frame), 40);
	}
	[self.collectionView reloadData];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	NSInteger sections = [self.datasource numberOfSections];
	[self.flowLayout invalidateLayout];
	return sections;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.datasource maximumNumberOfItemsPerSection];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = (SeatCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"seatCell" forIndexPath:indexPath];
//	NSString *seatName = [self.datasource seatCollectionView:self seatForIndexPath:indexPath].seat_Name;
//	SeatType type = [self.datasource seatCollectionView:self seatForIndexPath:indexPath].seat_Type;
//	SeatStatus status = [self.datasource seatCollectionView:self seatForIndexPath:indexPath].seatStatus;
	if ([selectedArray containsObject:indexPath]) {
		cell.selected = YES;
//		[self.collectionView  selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
	}
	else {
		cell.selected = NO;
//		status = [self.datasource seatCollectionView:self seatForIndexPath:indexPath].seatStatus;
	}
	[cell configureWithSeat:[self.datasource seatCollectionView:self seatForIndexPath:indexPath]];
	[cell addOverlay: [self.datasource seatCollectionView:self shouldHighlightIndexPath:indexPath]];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = (SeatCollectionCell *)[collectionView cellForItemAtIndexPath: indexPath];
	cell.selected = YES;
	[selectedArray addObject:indexPath];
	[self.datasource seatCollectionView:self didSelectIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = (SeatCollectionCell *)[collectionView cellForItemAtIndexPath: indexPath];
	cell.selected = NO;
	[selectedArray removeObject:indexPath];
	[self.datasource seatCollectionView:self didDeselectIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	BOOL shouldSelect = [self.datasource seatCollectionView:self shouldSelectIndexPath:indexPath];
	return shouldSelect;
}

@end

