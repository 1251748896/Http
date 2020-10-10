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
    [Http post:@{} url:@"123123123" config:@{}];
}
@end
