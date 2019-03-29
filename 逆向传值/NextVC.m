//
//  NextVC.m
//  逆向传值
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NextVC.h"
#import "Singleton.h"

@interface NextVC ()

@property(nonatomic,strong)UITextField *field;

@property(nonatomic,strong)UIButton *backbutton;
@end

@implementation NextVC
-(UITextField *)field{
    if (!_field) {
        _field = [[UITextField alloc]init];
        _field.frame = CGRectMake(100, 100, 100, 50);
        _field.borderStyle = UITextBorderStyleLine;
        _field.placeholder = @"请输入";
    }
    return _field;
}
-(UIButton *)backbutton{
    if (!_backbutton) {
        _backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backbutton.frame = CGRectMake(100, 200, 100, 50);
        [_backbutton setTitle:@"返回" forState:UIControlStateNormal];
        [_backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backbutton addTarget:self action:@selector(backbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbutton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.field];
    [self.view addSubview:self.backbutton];
    // Do any additional setup after loading the view from its nib.
    
    
}

-(void)backbuttonClick{
    switch (self.type) {
        case 0:
            {
                if (self.NextViewControllerBlock) {
                    self.NextViewControllerBlock(self.field.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case 1:
        {
            if ([self.delegate respondsToSelector:@selector(sendValue:)]) {
                [self.delegate sendValue:self.field.text];
                [self.navigationController popViewControllerAnimated:YES];
            }

            
        }
            break;
        case 2:
        {
            NSDictionary *dataDic = [NSDictionary dictionaryWithObject:self.field.text forKey:@"info"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 3:
        {
            Singleton *leton =  [Singleton sharedSingleton];
            leton.textF = self.field.text;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 4:
        {
            self.passingText = self.field.text;
            [self.navigationController popViewControllerAnimated:YES];
        }
            
            break;
        default:
            break;
    }
}


@end
