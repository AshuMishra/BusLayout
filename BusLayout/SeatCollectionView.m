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
@property (nonatomic, strong) UIView *headerView;

@end

@implementation SeatCollectionView

- (void)awakeFromNib {
	[super awakeFromNib];
	self.flowLayout = [[SeatFlowLayout alloc]init];
	self.collectionView.collectionViewLayout = self.flowLayout;
	self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
											collectionViewLayout:self.flowLayout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self addSubview:self.collectionView];
	self.collectionView.allowsSelection = YES;
	self.collectionView.allowsMultipleSelection = YES;
	UINib *nib = [UINib nibWithNibName:@"SeatCollectionCell" bundle:[NSBundle mainBundle]];
	[self.collectionView registerClass:[SeatCollectionCell class] forCellWithReuseIdentifier:@"seatCell"];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:@"seatCell"];
	[self.flowLayout registerNib:[UINib nibWithNibName:@"DriverSeatView" bundle:nil] forDecorationViewOfKind:@"DriverSeatView"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *prevIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.row];
	SeatType prevType = [self.datasource seatCollectionView:self seatTypeforIndexPath:prevIndexPath];
	if (prevType == SeatTypeSleeper) {
		return CGSizeZero;
	}else {
		SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
		return CGSizeMake(50, type == SeatTypeSleeper ? 100 : 50);
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

		self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
		self.headerView.frame = CGRectMake(0, -50, CGRectGetWidth(self.frame), 50);
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
	NSString *seatName = [self.datasource seatCollectionView:self seatNameforIndexPath:indexPath];
	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
	SeatStatus status = [self.datasource seatCollectionView:self seatStatusforIndexPath:indexPath];
	cell.type = type;
	[cell setType:type status:status name:seatName];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatCollectionCell *cell = (SeatCollectionCell *)[collectionView cellForItemAtIndexPath: indexPath];
	cell.selected = YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	SeatStatus status = [self.datasource seatCollectionView:self seatStatusforIndexPath:indexPath];
	return (status == SeatStatusAvailable);
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//	SeatType type = [self.datasource seatCollectionView:self seatTypeforIndexPath:indexPath];
//	return (type == SeatStatusAvailable);
//}

@end
