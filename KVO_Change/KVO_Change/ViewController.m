//
//  ViewController.m
//  KVO_Change
//
//  Created by 顺 on 2019/6/27Thursday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import "ViewController.h"
#import "GCSNotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lll:) name:@"2" object:nil];
    [[GCSNotificationCenter defaultCenter] gcs_addObserver:self selector:@selector(gcs_lll:) name:@"3" object:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"2" object:nil userInfo:nil];
    [[GCSNotificationCenter defaultCenter] gcs_postNotificationName:@"3" object:nil userInfo:@{@"l":@"lll"}];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"子线程发一个通知,接受者在主线程执行方法");
        [[GCSNotificationCenter defaultCenter] gcs_postNotificationName:@"3" object:nil userInfo:@{@"currentThread":[NSThread currentThread]}];

    });

}

- (void)lll:(NSNotification *)noti {
    NSLog(@"系统通知来了");
}

- (void)gcs_lll:(GCSNotification *)noti {
    NSLog(@"自定义通知来了 %@ %@",noti,noti.userInfo);
    NSLog(@"自定义通知线程 %@",[NSThread currentThread]);

}

- (void)dealloc {
    NSLog(@"%@ dealloc",[self class]);
    
    // 这个不写也可以的 , 其他地方调用的时候会顺便去掉target为nil的数据
//    [[GCSNotificationCenter defaultCenter] removeObserver:self];
}


@end
