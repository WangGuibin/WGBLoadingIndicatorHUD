//
//  LoadingIndicatorHUD.h
//  RefreshIndector
//
//  Created by Wangguibin on 16/3/22.
//  Copyright © 2016年 DDYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingIndicatorHUD : NSObject


/*!
 *  显示加载动画
 *
 *  @param message 加载信息
 */

+(void)showLoadIndicatorHUD:(NSString*)message;

/*!
 *  隐藏加载视图 移除动画
 */
+(void)hiddenloadIndicatorHUD;

@end
