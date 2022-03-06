//
//  WeChatLikeUIViewControllerCell.h
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//
#import <UIKit/UIKit.h>
#import "WeChatUITableViewController.h"
@interface MyWeChatUITableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *timelabel;
@property (weak, nonatomic) IBOutlet UITextView *MessageText;
@property (weak, nonatomic) IBOutlet UIImageView *BubbleImage;


@property (nonatomic,strong) MessageModel *messageModel;
@end

@interface YourWeChatUITableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *timelabel;
@property (weak, nonatomic) IBOutlet UIView *BubbleView;
@property (weak, nonatomic) IBOutlet UITextView *MessageText;


@property (nonatomic,strong) MessageModel *messageModel;
@end
