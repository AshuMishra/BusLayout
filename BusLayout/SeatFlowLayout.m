//
//  AppDelegate.m
//  CustomCalendar
//
//  Created by Susmita Horrow on 31/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatFlowLayout.h"
#import "SeatCollectionCell.h"
#import "SeatCollectionView.h"

#define NumberOfColumn	7

@interface SeatFlowLayout()

@property (nonatomic, strong) NSMutableDictionary *frameForIndexPath;

@end

@implementation SeatFlowLayout

- (void)prepareLayout {
	[super prepareLayout];
	self.frameForIndexPath = [NSMutableDictionary dictionary];

	CGFloat originX = 0.0;
	for(NSUInteger section = 0; section < self.collectionView.numberOfSections; section++) {
		NSInteger segment = [self.segmentIndexForSection[section] integerValue];
		CGFloat startingX = segment * self.interSegmentSpace;
		CGFloat originY = 0.0;

		CGFloat width = (self.collectionView.frame.size.width - self.interSegmentSpace)/ [self.collectionView numberOfSections];
		originX = startingX + section * width;

		for(NSUInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
			CGSize size;
			NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];

			if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
				id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
				size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
			}
			else {
				size = self.itemSize;
			}
			CGRect cellFrame = CGRectMake(originX, originY, width, size.height);
			originY +=  size.height;
			[self.frameForIndexPath setObject:NSStringFromCGRect(cellFrame) forKey:indexPath];
		}
	}
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
	UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath: indexPath];
	CGRect cellFrame = CGRectFromString([self.frameForIndexPath objectForKey: indexPath]);
	attributes.frame = cellFrame;
	return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
	NSMutableArray* elementsInRect = [NSMutableArray array];
	for(NSUInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
		for(NSUInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:item inSection:section];
			CGRect cellFrame = CGRectFromString([self.frameForIndexPath objectForKey: indexPath]);
			if(CGRectIntersectsRect(cellFrame, rect)) {
				//create the attributes object
				UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
				attr.frame = cellFrame;
				[elementsInRect addObject:attr];
			}
		}
	}

	return elementsInRect;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
	return YES;
}

- (CGSize)collectionViewContentSize{
	[super collectionViewContentSize];
	CGFloat finalHeight = 0.0;
	for(NSUInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
		CGFloat height = 0.0;
		for(NSUInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
			CGSize size;
			NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
			if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
				id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
				size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
			}
			else {
				size = self.itemSize;
			}
			height += size.height;
		}
		finalHeight = MAX(finalHeight, height);
	}
	CGSize newSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), finalHeight);
	return newSize;

}

@end
