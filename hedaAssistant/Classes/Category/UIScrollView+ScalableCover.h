//
//  UIBarButtonItem+XCC.h
//  XCNavTab
//  url:https://github.com/xiaocaiabc/XCNavTab
//  Created by bear on 16/3/31.
//  Copyright © 2016年 bear. All rights reserved.
//
#import <UIKit/UIKit.h>


static const CGFloat MaxHeight = 200;



@interface ScalableCover : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;

@end




@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image;
- (void)removeScalableCover;

@end

