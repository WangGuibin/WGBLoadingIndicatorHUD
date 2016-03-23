//
//  LoadingIndicatorHUD.m
//  RefreshIndector
//
//  Created by Wangguibin on 16/3/22.
//  Copyright © 2016年 DDYS. All rights reserved.
//

#import "LoadingIndicatorHUD.h"
#import <UIKit/UIKit.h>

#define KimageSize  38
#define Kmargin  10
#define  KLabelWidth  20
#define kAnimationTime  0.65f
#define kLoadBgHeight  80
#define kCoverAlpha   0.5f
#define Kwidth      [UIScreen mainScreen].bounds.size.width
#define Kheight     [UIScreen mainScreen].bounds.size.height

@interface LoadingIndicatorHUD ()

//动画图片
@property (nonatomic,strong) UIImageView * animationImage;

//展示信息的标签
@property (nonatomic,strong) UILabel *label;

//展示的灰色透明遮盖
@property (nonatomic,strong) UIView * coverView;

//加载视图的底图(中心的小白底)
@property (nonatomic,strong) UIView * loadBgView;


@end



@implementation LoadingIndicatorHUD

/*!
 *  显示加载动画
 *
 *  @param message 加载的信息
 */
+(void)showLoadIndicatorHUD:(NSString *)message
{

 [[LoadingIndicatorHUD share] loadingViewSetupWithText:message];

}

/*!
 *  隐藏加载动画
 */
+(void)hiddenloadIndicatorHUD
{

    [[LoadingIndicatorHUD share] dismiss];

}

/*!
 *
 *   隐藏视图  移除动画
 */
-(void)dismiss
{
    _coverView.hidden=YES;
    _loadBgView.hidden=YES;
    _animationImage.hidden=YES;
    [_animationImage.layer removeAnimationForKey:@"Rotation"];
}


/*!
 *  设置加载动画及文本
 *
 *  @param message 文本信息
 */
-(void)loadingViewSetupWithText:(NSString *)message
{
    _label.text=message;
    _coverView.hidden=NO;
    _loadBgView.hidden=NO;
    _animationImage.hidden=NO;

    //实例化基础动画对象 并设置绕z轴旋转 keypath 路径
    CABasicAnimation *rotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    旋转一周
    rotationAnimation.toValue=@(M_PI*2.0f);
    //动画的方式
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画周期
    rotationAnimation.duration=kAnimationTime;
    //循环次数
    rotationAnimation.repeatCount=MAXFLOAT;
    //累计次数
    rotationAnimation.cumulative=NO;
    //动画结束是否移除
    rotationAnimation.removedOnCompletion=NO;
    //动画填充模式
    rotationAnimation.fillMode=kCAFillModeForwards;
    //把动画加到layer层
    [_animationImage.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}


/*! *
 *  单例
 *
 *  @return 加载视图对象
 */
+(LoadingIndicatorHUD *)share
{
    static LoadingIndicatorHUD * loading = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loading=[[LoadingIndicatorHUD alloc]init];;
    });

    return loading;
}


// 初始化
-(instancetype)init
{
    self=[super init];
    if (self) {
        [self LoadingViewInit];
    }
    return self;
}


UIWindow *window;

//实例化
-(void)LoadingViewInit
{
   UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    window=keyWindow;

    _coverView =[ [UIView alloc]initWithFrame:window.frame];
    _coverView.backgroundColor = [UIColor colorWithWhite:kCoverAlpha alpha:kCoverAlpha];

    [window addSubview:_coverView];

    [_coverView addSubview:self.loadBgView];

    [_loadBgView addSubview:self.animationImage];

    [_loadBgView addSubview:self.label];

}


/*!
 *  懒加载底图
 *
 *  @return 返回一个底图
 */
- (UIView *)loadBgView
{
    if (_loadBgView==nil) {
        _loadBgView=[[UIView alloc]init];

        _loadBgView.backgroundColor=[UIColor whiteColor];

        [_loadBgView.layer setMasksToBounds:YES];

        [_loadBgView.layer setCornerRadius:6];
        _loadBgView.frame=CGRectMake(0, 0,  Kwidth/2, kLoadBgHeight);
        _loadBgView.center=_coverView.center;
    }
    return _loadBgView;
}

/*!
 *  懒加载图片
 *
 *  @return 返回一个图片对象
 */
- (UIImageView *)animationImage
{
    if (_animationImage==nil) {
        _animationImage=[[UIImageView alloc]init];


        _animationImage.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading.bundle/loading@2x.png" ofType:nil]];
        
        _animationImage.frame=CGRectMake((_loadBgView.frame.size.width-KimageSize)/2, Kmargin, KimageSize , KimageSize);
    }
    return _animationImage;
}

/*!
 *  懒加载文字标签
 *
 *  @return 返回一个标签
 */
- (UILabel *)label
{
    if (_label==nil) {

        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, Kmargin+KimageSize+3, _loadBgView.frame.size.width, KLabelWidth)];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:12];
        _label.textColor=[UIColor blackColor];
        _label.backgroundColor=[UIColor clearColor];
    }

    return _label;
}



@end
