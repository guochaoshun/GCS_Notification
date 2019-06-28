//
//  GCSNotificationModel.h
//  KVO_Change
//
//  Created by 顺 on 2019/6/28Friday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSNotificationModel : NSObject

@property (nonatomic,weak) id target ;
@property (nonatomic,assign) SEL sel ;
@property (nonatomic,weak) id notiObject ;

@end

NS_ASSUME_NONNULL_END
