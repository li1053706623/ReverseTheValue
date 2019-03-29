//
//  ViewController.m
//  逆向传值
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NextVC.h"
#import "Singleton.h"

@interface ViewController ()<VcBDelegate>

@property(nonatomic,strong)UILabel *lanbel;

@end

@implementation ViewController

- (UILabel *)lanbel{
    if (!_lanbel) {
        _lanbel = [[UILabel alloc]init];
        _lanbel.textColor = [UIColor blackColor];
        _lanbel.font = [UIFont systemFontOfSize:15];
        _lanbel.frame = CGRectMake(100, 100, 100, 20);
//        _lanbel.text = @"label";
    }
    return _lanbel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lanbel];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"Block传值",
                                                    @"代理传值",
                                                    @"通知传值",
                                                    @"单例传值",
                                                    @"KVO传值",nil];
    for (NSInteger index = 0; index < titleArray.count; index ++) {
         UIButton *kbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        kbutton.frame = CGRectMake(100, index * 50 + 150, 100, 50);
         [kbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [kbutton setTitle:[NSString stringWithFormat:@"%@",titleArray[index]] forState:UIControlStateNormal];
        kbutton.tag = index;
        [kbutton addTarget:self action:@selector(PassByValue:) forControlEvents:UIControlEventTouchUpInside];
   
        [self.view addSubview:kbutton];
    }
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"infoNotification" object:nil];
    
    [self test1];
   
    
}
-(void)test1{
   
    
   
}
- (void)PassByValue:(UIButton *)button {
    NextVC *vc = [[NextVC alloc]init];
    vc.type = button.tag;
    vc.delegate = self;
    vc.NextViewControllerBlock = ^(NSString * _Nonnull tfText) {
        self.lanbel.text = tfText;
    };
    
    [vc addObserver:self forKeyPath:@"passingText" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)sendValue:(NSString *)value{
    self.lanbel.text = value;
}

-(void)receiveNotification:(NSNotification *)infoNotification {
    self.lanbel.text = [infoNotification.userInfo objectForKey:@"info"];
}

/** 单例传值
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.lanbel.text = [Singleton sharedSingleton].textF;
}
 */
//必须实现这个方法, 这个是用来回调取值的!
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NextVC *vc = (NextVC *)object;
    if ([keyPath isEqualToString:@"passingText"]) {
        self.lanbel.text = [change objectForKey:@"new"];
    }
    [vc removeObserver:self forKeyPath:@"passingText"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
