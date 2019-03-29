//
//  Singleton.h
//  逆向传值
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

@property(nonatomic,strong)NSString *textF;

+(instancetype)sharedSingleton;

@end

NS_ASSUME_NONNULL_END
