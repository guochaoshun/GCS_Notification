//
//  ViewController.m
//  KVO_Change
//
//  Created by 顺 on 2019/6/27Thursday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "GCSNotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        SecondViewController * sec = [[SecondViewController alloc] init];
        [self.navigationController pushViewController:sec animated:YES];
        
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 此处在发送已经不会有方法执行了
    [[GCSNotificationCenter defaultCenter] gcs_postNotificationName:@"3" object:nil userInfo:@{@"l":@"拉拉拉"}];

}



@end
