//
//  CalendarViewController.m
//  xiaoyima
//
//  Created by qdazzle on 2022/2/28.
//

#import <Foundation/Foundation.h>
#import "CalendarViewController.h"
#import "NSDate+JFCalendarHelp.h"
#import "CalendarViewCell.h"
@interface CalendarViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIView *CalendarView;
@property (weak, nonatomic) IBOutlet UILabel *selectedMonthLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *CalendarCollectionView;
@property(nonatomic , assign)NSInteger firstWeekday; ///< 第一个周几
@property(nonatomic , assign)NSInteger monthDay; ///< 月日数
@property(nonatomic , assign)NSInteger selectedMonth; ///< 本月
@property(nonatomic, assign)NSInteger selectedDay;///<本日
@property(nonatomic , assign)NSInteger selectedYear; ///< 本年
@property (weak, nonatomic) IBOutlet UILabel *sunday;
@property (weak, nonatomic) IBOutlet UIView *Popupwindow;
@property (weak, nonatomic) IBOutlet UILabel *CoverLabel;
//@property (weak, nonatomic) UILabel *CoverLabel;
@property (weak, nonatomic) IBOutlet UIButton *MensesRecord;
@property (weak, nonatomic) CalendarViewCell *OnClickCell;
@end

@implementation CalendarViewController
-(BOOL)CheckRegister{
    //这里请求服务器登陆状态
    //或者读取存储的账户信息
    return false;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(![self CheckRegister]){
        [self performSegueWithIdentifier:@"loginView" sender:self];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _CalendarCollectionView.frame=CGRectMake(_CalendarCollectionView.frame.origin.x,_CalendarCollectionView.frame.origin.y,_CalendarCollectionView.frame.size.width,[[UIScreen mainScreen] bounds].size.width/7*5);
    });
}
- (IBAction)MensesRecordOnClick:(id)sender {
    _OnClickCell.dayLabel.layer.backgroundColor=[UIColor redColor].CGColor;
    _CoverLabel.hidden=YES;
    _Popupwindow.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_CalendarView setFrame:[UIScreen mainScreen].bounds];
    [_CalendarView setNeedsLayout];
    // Do any additional setup after loading the view, typically from a nib.
    
    _CalendarCollectionView.delegate = self;
    _CalendarCollectionView.dataSource = self;
    _selectedYear = [NSDate currentYear];
    _selectedMonth = [NSDate currentMonth];
    _selectedDay = [NSDate currentDay];

    _firstWeekday = [NSDate firstWeekdayFromYear:_selectedYear month:_selectedMonth];
    _selectedMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月",_selectedYear,_selectedMonth];
    _Popupwindow.layer.borderColor = [UIColor blackColor].CGColor;
    _Popupwindow.layer.borderWidth = 0.3f;
    _Popupwindow.hidden=true;
    _CoverLabel.frame= CGRectMake([[UIScreen mainScreen] bounds].origin.x,[[UIScreen mainScreen] bounds].origin.y,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    //_CoverLabel.frame = CGRectMake([[UIScreen mainScreen] bounds].origin.x,[[UIScreen mainScreen] bounds].origin.y,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    _CoverLabel.backgroundColor=[UIColor clearColor];
    _CoverLabel.hidden=YES;
    _OnClickCell=nil;
    
}

- (IBAction)lastMonthAction:(id)sender {
    
    if (_selectedMonth > 1) {
        _selectedMonth --;
    }
    else{
        _selectedYear --;
        _selectedMonth = 12;
    }
    [self changeTheSelectDay];
}

- (IBAction)nextMonthAction:(id)sender {
    if (_selectedMonth < 12) {
        _selectedMonth ++;
    }
    else{
        _selectedYear ++;
        _selectedMonth = 1;
    }
    [self changeTheSelectDay];
}

- (void)changeTheSelectDay{
    _firstWeekday = [NSDate firstWeekdayFromYear:_selectedYear month:_selectedMonth];
    
    _selectedMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月",_selectedYear,_selectedMonth];
    
    [_CalendarCollectionView reloadData];
}

#pragma mark collection delegate

#pragma mark collection datasource
/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWidth = _CalendarCollectionView.frame.size.width/7;
    
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}

/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     return _firstWeekday + [NSDate numberOfDaysByYear:_selectedYear month:_selectedMonth];
}

/**
 创建区头视图和区尾视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    return nil;
    
    
}

- (void)labelClick {
    _CoverLabel.hidden=YES;
    _Popupwindow.hidden=YES;
}
/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    _CoverLabel.userInteractionEnabled=YES;
    [_CoverLabel addGestureRecognizer:labelTapGestureRecognizer];
    _CoverLabel.hidden=NO;
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGPoint cellCenter = attributes.center;
    CGPoint anchorPoint = [collectionView convertPoint:cellCenter toView:self.view];
    _Popupwindow.hidden=false;
    CGFloat popviewcenterx,popviewcentery;
    if(anchorPoint.x+_Popupwindow.frame.size.width < [[UIScreen mainScreen] bounds].size.width)
        popviewcenterx = anchorPoint.x+_Popupwindow.frame.size.width/2;
    else
        popviewcenterx = anchorPoint.x-_Popupwindow.frame.size.width/2;
    if(anchorPoint.y+_Popupwindow.frame.size.height < [[UIScreen mainScreen] bounds].size.height)
        popviewcentery = anchorPoint.y+_Popupwindow.frame.size.height/2;
    else
        popviewcentery = anchorPoint.y-_Popupwindow.frame.size.height/2;
    _Popupwindow.center = CGPointMake(popviewcenterx, popviewcentery);
    _OnClickCell=[collectionView cellForItemAtIndexPath:indexPath];
}
/**
 创建cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    

    if (indexPath.row >=  _firstWeekday) {
        cell.dayLabel.text = [NSString stringWithFormat:@"  %ld",indexPath.row - _firstWeekday + 1];

    }
    else{
        cell.dayLabel.text = @"";
    }
    
    cell.dayLabel.layer.cornerRadius=_CalendarCollectionView.frame.size.width/14;
    cell.dayLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}
/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


/**
 区头大小
 */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(0, 0);
//}
/**
 区尾大小
 */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(0, 0);
//}
@end
