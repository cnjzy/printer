//
//  ViewController.m
//  SocketPrinterDemo
//
//  Created by Jzy on 15/10/22.
//  Copyright © 2015年 Jzy. All rights reserved.
//

#import "ViewController.h"
#import "PrinterUtils.h"

#define mIp @"172.18.111.240"
#define mPort 8188

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 打印字符串
-(IBAction)haha:(id)sender{
    
    // 创建连接
    BOOL isConnect = [[PrinterUtils getInstance] connectPrinter:mIp prot:mPort];
    NSLog(@"%d", isConnect);
    
    NSMutableString *sendString=[NSMutableString stringWithCapacity:100000];
    [sendString appendString:@"Socket测试成功！！！！\n"];
    [sendString appendString:@"Dish：1\n"];
    [sendString appendString:@"Dish：2\n"];
    [sendString appendString:@"Dish：3\n"];
    [sendString appendString:@"Dish：4\n"];
    [sendString appendString:@"Dish：5\n\n\n\n\n"];
    [[PrinterUtils getInstance] printByString:sendString];
}

@end
