//
//  WeChatUITableViewController.h
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WeChatUITableViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *arrMessageModel;

@end

@interface MessageModel :NSObject
@property (nonatomic,strong) NSString *userAlias;
@property (nonatomic,strong) NSString *messageText;
@property (nonatomic,strong) NSDate *datetime;

@end

