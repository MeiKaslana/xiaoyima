//
//  WeChatLikeUIViewController.m
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import "WeChatTalkUIView.h"
@interface WeChatTalkUIView ()

@end
@implementation WeChatTalkUIView
-(void)didAddSubview:(UIView *)subview{
    
    self.layer.backgroundColor=[UIColor greenColor].CGColor;
    self.layer.borderWidth = 0.2f;
    [super didAddSubview:subview];
}


@end
