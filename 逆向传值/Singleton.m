//
//  Singleton.m
//  逆向传值
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

//使用GCD来实现的单例创建
+(instancetype)sharedSingleton{
     static Singleton *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    if (!_sharedSingleton) {
        dispatch_once(&onceToken, ^{
             _sharedSingleton = [[Singleton alloc]init];
        });
       
    }

    return _sharedSingleton;
}

@end
