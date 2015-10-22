//
//  PrinterUtils.m
//  SocketPrinterDemo
//
//  Created by Jzy on 15/10/22.
//  Copyright © 2015年 Jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrinterUtils.h"



@interface PrinterUtils ()

@end

@implementation PrinterUtils

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
 * 实现单例方法
 */
+ (PrinterUtils *)getInstance{
    static PrinterUtils *share;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        share = [[self alloc] init];
    });
    return share;
}

/*
 * 创建连接
 */
- (BOOL) connectPrinter:(NSString*)ip prot:(NSInteger)port{
    asyncSocket=nil;
    NSError *err = nil;
    if(![asyncSocket connectToHost:ip onPort:port error:&err])
    {
        asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
        [asyncSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        
        if (![self SocketOpen:ip port:port])
        {
            if([asyncSocket isConnected])
            {
                return YES;
            }
        }
    }
    return NO;
}

/*
 * 按照data类型输出
 */
- (void) printByData: (NSData*) data
{
    [asyncSocket writeData:data withTimeout:-1 tag:0];
}

/*
 * 按照字符串类型输出
 */
- (void) printByString: (NSString*)text
{
    // 转义为GBK格式字符串
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *cmdData = [text dataUsingEncoding:gbkEncoding];
    [self printByData:cmdData];
}

// 建立连接
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"====didConnectToHost:%p didConnectToHost:%@ port:%hu", sock, host, port);
    [sock readDataWithTimeout:1 tag:0];
}

// 读取数据
-(void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"====didReadData");
}

// 是否加密
- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"====didSecure:%p didSecure:YES", sock);
}

// 遇到错误时关闭连接
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"====willDisconnectWithError:%p willDisconnectWithError:%@", sock, err);
}

// 断开连接
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"====onSocketDidDisconnect:%p", sock);
}

- (void)viewDidUnload {
    asyncSocket=nil;
}
//打开
- (NSInteger)SocketOpen:(NSString*)addr port:(NSInteger)port
{
    if (![asyncSocket isConnected])
    {
        [asyncSocket connectToHost:addr onPort:port withTimeout:-1 error:nil];
        
        NSLog(@"====SocketOpen connect to Host:%@ Port:%ld",addr,port);
    }else{
        NSLog(@"===SocketOpen fail");
    }
    return 0;
}

@end
