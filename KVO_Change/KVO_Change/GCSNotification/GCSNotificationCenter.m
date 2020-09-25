//
//  GCSNotificationCenter.m
//  KVO_Change
//
//  Created by 顺 on 2019/6/28Friday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import "GCSNotificationCenter.h"
#import "GCSNotificationModel.h"

@interface GCSNotificationCenter ()

@property (nonatomic,strong) NSMutableDictionary<NSString*,NSMutableArray*> * dataDic ;

@end

@implementation GCSNotificationCenter

+ (GCSNotificationCenter *)defaultCenter {
    static dispatch_once_t onceToken;
    static GCSNotificationCenter * center = nil;
    dispatch_once(&onceToken, ^{
        center = [[GCSNotificationCenter alloc] init];
    });
    return center;
    
}



- (void)gcs_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(nullable id)anObject {
    
    if (aName == nil || observer == nil) return;
    
    GCSNotificationModel * model = [[GCSNotificationModel alloc] init];
    model.target = observer;
    model.sel = aSelector;
    model.notiObject = anObject;
    
    // 用数组保存同一个aName所有监听者
    NSMutableArray * nameArray = [self.dataDic objectForKey:aName] ;
    if (nameArray == nil) {
        nameArray = [NSMutableArray array];
        [nameArray addObject:model];
        [self.dataDic setObject:nameArray forKey:aName];
        
    } else {
        [nameArray addObject:model];
    }
    
}

- (void)gcs_postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    
    NSMutableArray * nameArray = [self.dataDic objectForKey:aName] ;
    if (nameArray == nil) {
        NSLog(@"%@没有监听者",aName);
        return;
    }
    
    GCSNotification * noti = [[GCSNotification alloc] init];
    noti.name = aName;
    noti.senderObject = anObject;
    noti.userInfo = [aUserInfo copy];
    
    for (GCSNotificationModel * model in nameArray) {
        
        // 说明是给所有的监听者发送
        if (anObject == nil) {
            [self __sendActionOnMainThread:model noti:noti];
            continue;
        }
        
        // anObject存在, 说明是要给特定的监听者发送
        if ([model.notiObject isEqual:noti.senderObject]) {
            [self __sendActionOnMainThread:model noti:noti];
        }
        
    }
    
    
}

- (void)__sendActionOnMainThread:(GCSNotificationModel *)notiModel noti:(GCSNotification *)noti {

    // 不支持此方法,
    if ([notiModel.target respondsToSelector:notiModel.sel] == NO) {
        NSLog(@"%@不支持此方法%@",notiModel.target,NSStringFromSelector(notiModel.sel) );
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    if ([NSThread isMainThread]) {
        [notiModel.target performSelector:notiModel.sel withObject:noti];
    } else {
        [notiModel.target performSelectorOnMainThread:notiModel.sel withObject:noti waitUntilDone:YES];
    }
    
#pragma clang diagnostic pop

    
}


- (void)removeObserver:(id)observer {
    
    for (NSString * key in self.dataDic) {
        
        NSMutableArray * array = self.dataDic[key] ;
        NSMutableArray * delArray = [NSMutableArray array];
        for (GCSNotificationModel * model in array) {
            
            if (model.target == observer || model.target == nil) {
                [delArray addObject:model];
                continue;
            }
        }
        [array removeObjectsInArray:delArray];
        if (array.count == 0) {
            [self.dataDic removeObjectForKey:key];
        }
        
    }
    
}


- (NSMutableDictionary *)dataDic {
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}


@end
