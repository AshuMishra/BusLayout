//
//  ViewController.h
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatCollectionView.h"

@interface SeatLayoutController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *priceCollectionView;
@property (weak, nonatomic) IBOutlet SeatCollectionView *lowerSeatCollectionView;
@property (weak, nonatomic) IBOutlet SeatCollectionView *upperSeatCollectionView;
@property (nonatomic,retain) NSString * busKey;
@property (weak, nonatomic) IBOutlet UILabel *travellerName;
@property (nonatomic,retain) NSString * travelsName;
@property (nonatomic, strong) NSMutableArray *priceArray;
@property (nonatomic, strong) NSMutableArray *boardingPointArray;

@end

