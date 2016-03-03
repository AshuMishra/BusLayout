//
//  ViewController.m
//  BusLayout
//
//  Created by Susmita Horrow on 13/02/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

#import "SeatLayoutController.h"
#import "PriceCell.h"
#import "SeatModel.h"
#define MaximumAllowedSelection 6

@interface SeatLayoutController()<SeatCollectionViewDatasource> {
	NSArray * seatsArray;
//	PersitenceManager *persitenceManager;
//	Utils *utils;
	NSOperationQueue *operationQueue;
	NSInteger maximumNumberOfItemsPerSection;
	NSInteger numberOfSections;
	NSInteger startSectionUppar;
}
@property (nonatomic, strong) NSArray * upperSeatsArray;
@property (nonatomic, strong) NSArray *lowerSeatsArr;
@property (nonatomic, strong) NSMutableArray *indexPathsForUpperSelectedSeats;
@property (nonatomic, strong) NSMutableArray *indexPathsForLowerSelectedSeats;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yConstraintsOfPriceCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yConstraintsOfIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *seatIndicatorView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (assign, nonatomic) NSInteger selectedPriceIndex;
@end

@implementation SeatLayoutController
@synthesize busKey;
@synthesize travelsName,priceArray;

#pragma mark- View Controllers Method:-
- (void)viewDidLoad {
	[super viewDidLoad];
	self.lowerSeatCollectionView.datasource = self;
	self.upperSeatCollectionView.datasource = self;

//	utils = [[Utils alloc]init];
//	persitenceManager = [[PersitenceManager alloc]init];
	operationQueue = [[NSOperationQueue alloc] init];

	self.segmentControl.hidden = true;
	self.yConstraintsOfPriceCollectionView.constant = -40.0f;

	UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.seatIndicatorView.bounds];
	self.seatIndicatorView.layer.masksToBounds = NO;
	self.seatIndicatorView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
	self.seatIndicatorView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
	self.seatIndicatorView.layer.shadowOpacity = 0.5f;
	self.seatIndicatorView.layer.shadowPath = shadowPath.CGPath;


	maximumNumberOfItemsPerSection = 0;
	numberOfSections = 0;
	self.travellerName.text =  self.travelsName;
	NSLog(@"%@",self.priceArray);
	self.priceArray = [NSMutableArray arrayWithObjects:@"All", @"912", @"1318", nil];
	self.selectedPriceIndex = 0;
//	if (priceArray.count>1) {
//		[priceArray insertObject:@"All" atIndex:0];
//		self.priceCollectionView.hidden = NO;
//		self.yConstraintsOfIndicatorView.constant = 0.0f;
//	}
//	else {
//		self.priceCollectionView.hidden = YES;
//		self.yConstraintsOfIndicatorView.constant = -50.0f;
//	}
	[self configureData];
	[self getBusLayout];
	[self setNavigationBar];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[self.lowerSeatCollectionView reloadSeatCollectionViewWithHeader:YES];
	[self.upperSeatCollectionView reloadSeatCollectionViewWithHeader:NO];
}

- (void)configureData {
	NSString *str = @"{\"Wallet\":{\"ResponseCode\":0,\"ResponseMessage\":\"Success\",\"CurrentDateTime\":\"2016-02-18T22:35:56.3313656+05:30\",\"DataCollection\":{\"data\":{\"onwardSeats\":[{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"0.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"1\",\"serviceCharge\":0,\"SeatFare\":\"0\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"true\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"1\",\"seat_status\":\"bookedSeat\",\"SeatStatus\":\"0\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"4\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"3\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"5\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"8\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"5\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"9\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"12\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"7\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"13\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"16\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"0\",\"Deck\":\"1\",\"ColumnNo\":\"9\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"17\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"1\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"2\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"3\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"3\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"6\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"7\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"5\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"10\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"11\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"7\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"14\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"15\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7500\",\"ActualSeatFare\":\"912.0\",\"SeatType\":\"Seater\",\"RowNo\":\"1\",\"Deck\":\"1\",\"ColumnNo\":\"9\",\"serviceCharge\":0,\"SeatFare\":\"912\",\"Height\":\"1\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"851.00\",\"ServiceTax\":\"49.00\",\"SeatName\":\"18\",\"seat_status\":\"availableSeat\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"3\",\"Deck\":\"1\",\"ColumnNo\":\"0\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"true\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"C\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"0\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"3\",\"Deck\":\"1\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"F\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"3\",\"Deck\":\"1\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"K\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"3\",\"Deck\":\"1\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"N\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"3\",\"Deck\":\"1\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"S\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"6\",\"Deck\":\"2\",\"ColumnNo\":\"0\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"A\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"6\",\"Deck\":\"2\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"H\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"6\",\"Deck\":\"2\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"I\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"6\",\"Deck\":\"2\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"P\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"6\",\"Deck\":\"2\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"Q\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"7\",\"Deck\":\"2\",\"ColumnNo\":\"0\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"B\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"7\",\"Deck\":\"2\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"G\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"7\",\"Deck\":\"2\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"J\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"7\",\"Deck\":\"2\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"O\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"7\",\"Deck\":\"2\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"R\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"9\",\"Deck\":\"2\",\"ColumnNo\":\"0\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"D\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"9\",\"Deck\":\"2\",\"ColumnNo\":\"2\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"E\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"9\",\"Deck\":\"2\",\"ColumnNo\":\"4\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"L\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"9\",\"Deck\":\"2\",\"ColumnNo\":\"6\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"M\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"},{\"ServiceTaxPercentage\":\"5.7700\",\"ActualSeatFare\":\"1318.0\",\"SeatType\":\"Sleeper\",\"RowNo\":\"9\",\"Deck\":\"2\",\"ColumnNo\":\"8\",\"serviceCharge\":0,\"SeatFare\":\"1318\",\"Height\":\"2\",\"Width\":\"1\",\"LSeat\":\"false\",\"BaseFare\":\"1229.00\",\"ServiceTax\":\"71.00\",\"SeatName\":\"T\",\"seat_status\":\"availableSleeper\",\"SeatStatus\":\"1\",\"row_type\":\"onwardflights\"}],\"onwardBPs\":{\"status\":\"V\",\"timestamp\":\"2016-02-18T18:27:22.167848\",\"row_type\":\"onwardflights\",\"datafrom\":\"redbusnew\",\"GetBoardingPointsResult\":{\"list\":[{\"BPLocation\":\"ROYAL(office),Gurudwara Road, Opp. K. D. Complex\",\"BPContactNumber\":\"\",\"BPTime\":\"2016-02-20T22:00:00+05:30\",\"BPName\":\"82927-ROYAL(office),Gurudwara Road, Opp. K. D. Complex\",\"BPAddress\":\"\"},{\"BPLocation\":\"victoria bridge\",\"BPContactNumber\":\"\",\"BPTime\":\"2016-02-20T22:15:00+05:30\",\"BPName\":\"82934-victoria bridge\",\"BPAddress\":\"\"},{\"BPLocation\":\"gulabnagar\",\"BPContactNumber\":\"\",\"BPTime\":\"2016-02-20T22:20:00+05:30\",\"BPName\":\"82935-gulabnagar\",\"BPAddress\":\"\"}]},\"NoOfBPs\":3,\"datasource\":\"R\",\"rowid\":\"BUS@GETBOARDINGPOINTS@2a8be29c-d662-11e5-bdd4-ea5d43f98a9f\",\"CNTR_error\":\"None\"},\"returnflightsMaxC\":\"0\",\"returnBPs\":{},\"returnSeats\":[],\"onwardflightsMaxC\":\"10\",\"returnflightsMaxR\":\"0\",\"onwardflightsMaxR\":\"10\"},\"ErrorMessage\":null}}}";
	NSDictionary *dict = [self json_StringToDictionary:str];

	NSDictionary *wallet = [dict objectForKey:@"Wallet"];
	NSDictionary *dataCollection = [wallet objectForKey:@"DataCollection"];
	NSDictionary *data = [dataCollection objectForKey:@"data"];
	NSArray *onwardSeats = [data objectForKey:@"onwardSeats"];
//	NSLog(@"onwardSeats = %@", onwardSeats);
	seatsArray = [SeatModel seatsFromArray:onwardSeats];

	self.lowerSeatsArr = [seatsArray filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"seat_Deck == 1"]];
	SeatModel *seatObj = self.lowerSeatsArr.lastObject;

	maximumNumberOfItemsPerSection = seatObj.seat_Type == SeatTypeSleeper? seatObj.seat_Column+2: seatObj.seat_Column+1;
	numberOfSections = seatObj.seat_Row+1;

	NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"seat_Deck == 2"];
	self.upperSeatsArray = [seatsArray filteredArrayUsingPredicate:bPredicate];

	seatObj = self.upperSeatsArray.firstObject;
	startSectionUppar = seatObj.seat_Row;

	if (self.upperSeatsArray.count!=0) {
		self.segmentControl.hidden = false;
		self.yConstraintsOfPriceCollectionView.constant = 0.0f;
	}
	[self.lowerSeatCollectionView reloadSeatCollectionViewWithHeader:YES];
	[self.upperSeatCollectionView reloadSeatCollectionViewWithHeader:NO];
}

- (NSDictionary *) json_StringToDictionary:(NSString *)string {
	NSError *error;
	NSData *objectData = [string dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&error];
	return (!json ? nil : json);
}

- (SeatModel *)seatForIndexPath:(NSIndexPath *)indexPath {
	if(self.segmentControl.selectedSegmentIndex == 0) {
		NSPredicate *lowerSeatPredicate = [NSPredicate predicateWithFormat:@"seat_Row == %d AND seat_Column = %d", indexPath.section, indexPath.item];
		SeatModel *seat = [self.lowerSeatsArr filteredArrayUsingPredicate: lowerSeatPredicate].firstObject;
		return seat;
	}else {
		NSPredicate *upperSeatPredicate = [NSPredicate predicateWithFormat:@"seat_Row == %d AND seat_Column = %d", (startSectionUppar + indexPath.section), indexPath.item];
		SeatModel *seat = [self.upperSeatsArray filteredArrayUsingPredicate: upperSeatPredicate].firstObject;
		return seat;
	}
}

#pragma mark- Segment Methods:-

- (NSInteger)numberOfSections {
	return numberOfSections;
}
- (SeatModel *)seatCollectionView:(SeatCollectionView *)collectionView seatForIndexPath:(NSIndexPath *)indexPath {
	return [self seatForIndexPath:indexPath];
}

- (NSInteger)maximumNumberOfItemsPerSection {
	return maximumNumberOfItemsPerSection;
}

- (BOOL)seatCollectionView:(SeatCollectionView *)collectionView shouldSelectIndexPath:(NSIndexPath *)indexPath {
	BOOL shouldSelect = (self.lowerSeatCollectionView.selectedIndexPaths.count + self.upperSeatCollectionView.selectedIndexPaths.count < MaximumAllowedSelection);
	return shouldSelect;
}

- (BOOL)seatCollectionView:(SeatCollectionView *)collectionView shouldHighlightIndexPath:(NSIndexPath *)indexPath {
	NSString *selectedPrice = [self.priceArray objectAtIndex:self.selectedPriceIndex];
	if ([selectedPrice isEqualToString:@"All"]) {
		return YES;
	}else {
		SeatModel *seat = [self seatForIndexPath:indexPath];
		NSString *priceValue = [[NSNumber numberWithFloat:seat.seat_Fare] stringValue];
		return [priceValue isEqualToString:selectedPrice];
	}
}

- (void)seatCollectionView:(SeatCollectionView *)collectionView didSelectIndexPath:(NSIndexPath *)indexPath {
	[self updateSelectedPrice:indexPath];
}

- (void)seatCollectionView:(SeatCollectionView *)collectionView didDeselectIndexPath:(NSIndexPath *)indexPath {
	[self updateSelectedPrice:indexPath];
}

- (void)updateSelectedPrice:(NSIndexPath *)indexPath {
	if (self.selectedPriceIndex == 0) {
		return;
	}
	SeatModel *seat = [self seatForIndexPath:indexPath];
	NSIndexPath *selectedPriceIndexPath = [[self.priceCollectionView indexPathsForSelectedItems]firstObject];
	NSString *selectedPrice = [self.priceArray objectAtIndex:selectedPriceIndexPath.item];
	NSString *priceValue = [[NSNumber numberWithFloat:seat.seat_Fare] stringValue];
	if(![priceValue isEqualToString:selectedPrice]) {
		NSInteger index = [self.priceArray indexOfObjectWithOptions:NSEnumerationReverse passingTest:^BOOL(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
			return [obj isEqualToString:priceValue];
		}];
		if (index != NSNotFound && index != self.selectedPriceIndex) {
			self.selectedPriceIndex = index;
			[self.priceCollectionView reloadData];
		}
	}
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
	priceCell.selected = indexPath.item == self.selectedPriceIndex;
	priceCell.priceLabel.textColor = [UIColor whiteColor];
	priceCell.layer.cornerRadius = priceCell.frame.size.width/2;
	priceCell.layer.masksToBounds = YES;
	return priceCell;
}


- (void)collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
	if (indexPath.item == self.selectedPriceIndex) { return; }
	NSIndexPath *prevIndexPath = [NSIndexPath indexPathForItem:self.selectedPriceIndex inSection:0];
	[collectionView deselectItemAtIndexPath:prevIndexPath animated:NO];
	self.selectedPriceIndex = indexPath.item;
	[collectionView reloadItemsAtIndexPaths:@[indexPath, prevIndexPath]];
	if (self.segmentControl.selectedSegmentIndex == 0) {
		[self.lowerSeatCollectionView reloadSeatCollectionViewWithHeader:YES];
	}else {
		[self.upperSeatCollectionView reloadSeatCollectionViewWithHeader:NO];
	}
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	NSInteger cellCount = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
	if( cellCount > 0 ) {
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


#pragma mark- Get Bus Layout Methods:-

-(void)getBusLayout {

//	if ([utils isInternetConnection]) {
//		[self showLoaderOnScreen];
//		BusLayoutManager *busLayoutManagerObj = [[BusLayoutManager alloc]init]; //Adding Operation to another thread
//		busLayoutManagerObj.delegate = self;
//		busLayoutManagerObj.buskey = self.busKey;
//		[operationQueue addOperation:busLayoutManagerObj];
//	}
}

//Delegate methods:-
//- (void) busLayoutReceived:(UserResponse *)userResponse :(NSArray *)seatListArray
//{
//	[operationQueue cancelAllOperations];
//	dispatch_async(dispatch_get_main_queue(), ^{
////		[super hideLoaderFromScreen];
//		if (userResponse != nil) {
//			if (userResponse.responseCode.integerValue == 0) {
//				seatsArray = [SeatModel seatsFromArray:seatListArray];
//				NSLog(@"seats = %@", seatsArray);
//
//				self.lowerSeatsArr = [seatsArray filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"seat_Deck == 1"]];
//				SeatModel *seatObj = self.lowerSeatsArr.lastObject;
//
//				maximumNumberOfItemsPerSection = seatObj.seat_Type == SeatTypeSleeper? seatObj.seat_Column+2: seatObj.seat_Column+1;
//				numberOfSections = seatObj.seat_Row+1;
//
//				NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"seat_Deck == 2"];
//				self.upperSeatsArray = [seatsArray filteredArrayUsingPredicate:bPredicate];
//
//				seatObj = self.upperSeatsArray.firstObject;
//				startSectionUppar = seatObj.seat_Row;
//
//				if (self.upperSeatsArray.count!=0) {
//					self.segmentControl.hidden = false;
//					self.yConstraintsofPriceCollV.constant = 0.0f;
//				}
//				[self.lowerSeatCollectionView reloadSeatCollectionViewWithHeader:YES];
//			}
//		}
//		else {
////			[utils alertShow: userResponse.message];
//		}
//	});
//}
//
//- (void) onErrorOccurred :(NSError *)error
//{
//	dispatch_async(dispatch_get_main_queue(), ^{
////		[self hideLoaderFromScreen];
//		[super onErrorOccuredInMainThread:error];
//
//
//	});
//}

#pragma mark- IBAction Methods:-
- (IBAction)doneButtonTapped:(id)sender {
}

-(void)setNavigationBar {
	UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(backClick)forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(0, 0, 50, 25)];

	UIImageView *imgCircle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 33, 20)];
	imgCircle.image =[UIImage imageNamed:@"back-icon"];
	[button addSubview:imgCircle];

	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
	self.navigationItem.leftBarButtonItem = barButton;

	NSDictionary *size=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil];
	self.navigationController.navigationBar.titleTextAttributes = size;

}

- (IBAction)handleSegmentChange:(id)sender {
	switch (self.segmentControl.selectedSegmentIndex) {
		case 0:
			self.upperSeatCollectionView.hidden = YES;
			self.lowerSeatCollectionView.hidden = NO;
			[self.lowerSeatCollectionView reloadSeatCollectionViewWithHeader:YES];
			break;

		case 1:
			self.upperSeatCollectionView.hidden = NO;
			self.lowerSeatCollectionView.hidden = YES;
			[self.upperSeatCollectionView reloadSeatCollectionViewWithHeader:NO];

		default:
			break;
	}
}

- (void)backClick {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
