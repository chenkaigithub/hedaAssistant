//
//  UIBarButtonItem+Create.h
//
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Create)
/**
 * 快速创建item
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemRoundWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

@end
