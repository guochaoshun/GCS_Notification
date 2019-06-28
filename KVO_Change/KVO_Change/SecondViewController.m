
//
//  SecondViewController.m
//  KVO_Change
//
//  Created by 顺 on 2019/6/27Thursday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import "SecondViewController.h"
#import "Person.h"
#import "GCSNotificationCenter.h"

@interface SecondViewController ()

@property (nonatomic,strong) Person * p ;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    Person * p = [Person new];
    self.p = p;

    [self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    p.name = @"1233";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lll:) name:@"2" object:nil];
    [[GCSNotificationCenter defaultCenter] gcs_addObserver:self selector:@selector(gcs_lll:) name:@"3" object:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 1;
    self.p.name = [NSString stringWithFormat:@"ssss%d",a];
    a++;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"2" object:nil userInfo:nil];
    [[GCSNotificationCenter defaultCenter] gcs_postNotificationName:@"3" object:nil userInfo:@{@"l":@"lll"}];
}

- (void)lll:(NSNotification *)noti {
    NSLog(@"通知来了");
}

- (void)gcs_lll:(GCSNotification *)noti {
    NSLog(@"gcs通知来了 %@ %@",noti,noti.userInfo);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@ %@ %@ %@",object,keyPath,change,context);
    
    
}

- (void)dealloc {
    NSLog(@"%@ dealloc",[self class]);
    
    // 这个不写也可以的 , 其他地方调用的时候会顺便去掉target为nil的数据
//    [[GCSNotificationCenter defaultCenter] removeObserver:self];
}








@end
