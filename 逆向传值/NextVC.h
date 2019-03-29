//
//  NextVC.h
//  逆向传值
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//创建协议
@protocol VcBDelegate <NSObject>

- (void)sendValue:(NSString *)value; //声明协议方法
@end

@interface NextVC : UIViewController

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)NSString *passingText;

//定义block
@property (nonatomic,copy) void (^NextViewControllerBlock)(NSString *tfText);


@property (nonatomic, weak)id<VcBDelegate> delegate; //声明协议变量


@end

NS_ASSUME_NONNULL_END
