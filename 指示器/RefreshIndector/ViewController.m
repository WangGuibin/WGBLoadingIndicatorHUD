//
//  ViewController.m
//  RefreshIndector
//
//  Created by Wangguibin on 16/3/22.
//  Copyright © 2016年 DDYS. All rights reserved.
//

#import "ViewController.h"
#import  "LoadingIndicatorHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LoadingIndicatorHUD showLoadIndicatorHUD:@"世界，你好"];


}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LoadingIndicatorHUD hiddenloadIndicatorHUD];

}

@end
