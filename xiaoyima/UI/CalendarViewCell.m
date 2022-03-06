//
//  CalendarViewController.m
//  xiaoyima
//
//  Created by qdazzle on 2022/2/28.
//

#import <Foundation/Foundation.h>
#import "CalendarViewCell.h"


@interface CalendarViewCell ()
@property (assign, nonatomic) bool isMensesStart;
@property (assign, nonatomic) bool isMensesStop;
@end

@implementation CalendarViewCell
- (void)didAddSubview:(UIView *)subview{
    _isMensesStart=NO;
    _isMensesStop=NO;
    [super didAddSubview:subview];
}
-(bool)MensesRecordPress{
    _isMensesStart=!_isMensesStart;
    _isMensesStop=NO;
    [self ChangeMensesRecordColor:_isMensesStart];
    return _isMensesStart;
}

-(bool)MensesEndPress{
    _isMensesStop=!_isMensesStop;
    _isMensesStart=YES;
    [self ChangeMensesEndColor:_isMensesStop];
    return _isMensesStop;
}

-(void)ChangeMensesRecordColor:(bool)isMensesStart{
    _dayLabel.layer.backgroundColor=isMensesStart?[UIColor redColor].CGColor:[UIColor clearColor].CGColor;
}

-(void)ChangeMensesEndColor:(bool)isMensesStart{
    _dayLabel.layer.backgroundColor=isMensesStart?[UIColor purpleColor].CGColor:[UIColor clearColor].CGColor;
}
@end
