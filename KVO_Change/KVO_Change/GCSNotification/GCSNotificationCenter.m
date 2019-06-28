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
    
    GCSNotificationModel * model = [[GCSNotificationModel alloc] init];
    model.target = observer;
    model.sel = aSelector;
    model.notiObject = anObject;
    
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
    GCSNotification * noti = [[GCSNotification alloc] init];
    noti.name = aName;
    noti.senderObject = anObject;
    noti.userInfo = aUserInfo;
    
    NSMutableArray * nameArray = [self.dataDic objectForKey:aName] ;
    for (GCSNotificationModel * model in nameArray) {
        
        if (model.notiObject == nil || [model.notiObject isEqual:noti.senderObject]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [model.target performSelector:model.sel withObject:noti];
#pragma clang diagnostic pop

        }
        
    }
    
    
}

- (void)removeObserver:(id)observer {
    
    for (int i = (int)self.dataDic.count-1; i>=0; i--) {
        NSString * key = self.dataDic.allKeys[i];
        NSMutableArray * nameArray = [self.dataDic objectForKey:key] ;
        for (int j = (int)nameArray.count-1; j>=0; j--) {
            GCSNotificationModel * model = nameArray[j];
            if ([model.target isEqual:observer] || model.target == nil) {
                [nameArray removeObject:model];
            }
            
        }
        
        if (nameArray.count == 0) {
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
