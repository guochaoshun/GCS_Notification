//
//  GCSNotification.h
//  KVO_Change
//
//  Created by 顺 on 2019/6/28Friday.
//  Copyright © 2019 智网易联. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSNotification : NSObject

@property (nonatomic,copy) NSString * name ;
@property (nonatomic,weak) id senderObject ;
@property (nonatomic,strong) NSDictionary * userInfo ;

@end

NS_ASSUME_NONNULL_END
