//
//  WeChatUITableViewController.h
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MessageModel :NSObject
@property (nonatomic,strong) NSString *userAlias;
@property (nonatomic,strong) NSString *messageText;
@property (nonatomic,strong) NSNumber *datetime;

@end

@interface WeChatUITableViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *arrMessageModel;
-(void)updateTableView:(MessageModel *)model;
@end



