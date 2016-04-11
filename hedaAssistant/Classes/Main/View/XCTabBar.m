//
//  XCTabBar.m
//  XCNavTab
//  url:https://github.com/xiaocaiabc/XCNavTab
//  Created by bear on 15/11/19.
//  Copyright © 2015年 bear. All rights reserved.
//

#import "XCTabBar.h"
#import "XCTabItem.h"

@implementation XCTabBar

- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title
{
    // 1.创建item
    XCTabItem *item = [[XCTabItem alloc] init];

    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    item.titleLabel.textColor=[UIColor lightGrayColor];

    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];


    [self addSubview:item];

    // 监听点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];





}


-(void)layoutSubviews{
    [super layoutSubviews];


    NSInteger count = self.subviews.count;

    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / count;

    for (int i = 0; i<count; i++) {


        XCTabItem *tabItem = self.subviews[i];
        //默认选中第一个
        if (i==1) {
            [self itemClick:tabItem];
        }
        
        tabItem .tag = i;
        tabItem .frame = CGRectMake(width * i, 0, width, height);
    }
}




#pragma mark 监听item点击
- (void)itemClick:(XCTabItem *)item
{

    if ([_delegate respondsToSelector:@selector(tabbar:to:)]) {
        [_delegate tabbar:self to:item.tag ];
    }

      // 1.取消选中
      _selectedItem.selected = NO;

      // 2.选中点击的item
      item.selected = YES;

      // 3.赋值
      _selectedItem = item;

}





@end
