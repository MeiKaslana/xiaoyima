//
//  SocketManager.m
//  xiaoyima
//
//  Created by qdazzle on 2022/3/6.
//

#import <Foundation/Foundation.h>
#import "SocketManager.h"
#import "GCDAsyncSocket.h"


static NSString *whost = @"localhost";
static const uint16_t wport = 8888;

@interface SocketManager() <GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket* gcdsocket;
@end
@implementation SocketManager

+(instancetype)shareSocket{
    static dispatch_once_t onceToken;
    static SocketManager *instance=nil;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
        [instance initSocket];
    });
    return instance;
}

- (void)initSocket{
    _gcdsocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

-(BOOL)connect{
    return [_gcdsocket connectToHost:whost onPort:wport error:nil];
}

-(void)disconnect{
    [_gcdsocket disconnect];
}

-(void)sendMessage:(NSDictionary *)msg{
    NSData *data=[NSJSONSerialization dataWithJSONObject:msg options:NSJSONWritingPrettyPrinted error:nil]; 
    [_gcdsocket writeData:data withTimeout:-1 tag:110];
}

-(void)listeningMsg{
    [_gcdsocket readDataWithTimeout:-1 tag:110];
}

-(void)checkPingPong{
    [_gcdsocket readDataWithTimeout:-1 tag:110];
}

// socketdelegate

//socket连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    [self checkPingPong];
}


//收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到数据 = %@ ",str);
    MessageModel *model = [[MessageModel alloc] init];
    model.userAlias =@"You";
    //从服务器或者本地读取
    model.messageText = str;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    model.datetime = [NSNumber numberWithDouble:timeInterval];
    if (self.WechatSocketDelegate) {
        [self.WechatSocketDelegate socketReadData:model];
    }
    [self checkPingPong];
}

//写成功回调
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self listeningMsg];
}

//socket断连回调
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    //断线重连在这
    NSLog(@"err ");
    NSLog([err description]);

}
@end

