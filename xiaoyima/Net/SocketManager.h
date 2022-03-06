//
//  SocketManager.h
//  xiaoyima
//
//  Created by qdazzle on 2022/3/6.
//

#import <Foundation/Foundation.h>
#import "WeChatUITableViewController.h"

@protocol SocketDelegate <NSObject>
@required
- (void) socketReadData:(MessageModel *)model;
@end

@interface SocketManager : NSObject
@property (nonatomic, assign) id<SocketDelegate> WechatSocketDelegate;

+(instancetype)shareSocket;
-(void)initSocket;
-(BOOL)connect;

-(void)disconnect;

-(void)sendMessage:(NSDictionary *)msg;

-(void)listeningMsg;

-(void)checkPingPong;
@end


