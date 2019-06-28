//
//  GCSNotificationCenter.h
//  KVO_Change
//
//  Created by 顺 on 2019/6/28Friday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCSNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCSNotificationCenter : NSObject


@property (class, readonly, strong) GCSNotificationCenter *defaultCenter;

- (void)gcs_addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)gcs_postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;




@end

NS_ASSUME_NONNULL_END
