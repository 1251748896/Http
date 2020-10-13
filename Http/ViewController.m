//
//  ViewController.m
//  Http
//
//  Created by HaoHuoBan on 2020/9/28.
//  Copyright © 2020 HaoHuoBan. All rights reserved.
//

#import "ViewController.h"
#import "Http.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *url = @"https://itunes.apple.com/cn/lookup?id=1495123590";
    [Http post:@{} url:url callback:^(id _Nonnull data) {
        NSLog(@"数据 = %@",data);
    }];
}
@end
