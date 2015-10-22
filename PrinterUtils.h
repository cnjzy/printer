//
//  PrinterUtils.h
//  SocketPrinterDemo
//
//  Created by Jzy on 15/10/22.
//  Copyright © 2015年 Jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface PrinterUtils : NSObject<AsyncSocketDelegate>{
    AsyncSocket *asyncSocket;
}

/*
 * 单例方法
 */
+ (PrinterUtils*) getInstance;

/*
 * 创建连接
 */
- (BOOL) connectPrinter:(NSString*)ip prot:(NSInteger)port;

/*
 * 按照data类型输出
 */
- (void) printByData: (NSData*) data;

/*
 * 按照字符串类型输出
 */
- (void) printByString: (NSString*)text;

@end
