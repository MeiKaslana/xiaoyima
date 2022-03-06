//
//  WeChatLikeUIViewControllerCell.m
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//
#import <Foundation/Foundation.h>
#import "WeChatUITableViewCell.h"


@interface MyWeChatUITableViewCell ()

@end

@implementation MyWeChatUITableViewCell
-(void)didAddSubview:(UIView *)subview{
    NSTimeInterval timeInterval=[_messageModel.datetime doubleValue];
    NSDate *online = [NSDate date];
    online = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:online];
    [_timelabel setText:currentDateStr];
    [_MessageText setText:_messageModel.messageText];
    [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
}
@end

@interface YourWeChatUITableViewCell ()

@end

@implementation YourWeChatUITableViewCell
-(void)didAddSubview:(UIView *)subview{
    UIImage *bubble=[UIImage imageNamed:@"bubblebackground.png"];
    [_BubbleView setBackgroundColor:[UIColor colorWithPatternImage:bubble]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:_messageModel.datetime];
    [_timelabel setText:currentDateStr];
    [_MessageText setText:_messageModel.messageText];
    [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
}
@end
