//
//  XCNavigationController.m
//  hedaAssistant
//  url:https://github.com/xiaocaiabc/XCNavTab
//  Created by bear on 16/3/24.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "XCNavigationController.h"
#import "UINavigationItem+custom.h"
#import "UIBarButtonItem+XCC.h"


@interface XCNavigationController ()<UINavigationControllerDelegate>



@end

@implementation XCNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setTintColor:[UIColor whiteColor]];

    self.navigationBar.shadowImage = [[UIImage alloc] init];








}





- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count){ // 不是根控制器
        // push的时候隐藏底部条
        viewController.hidesBottomBarWhenPushed = YES;
    }



    //          tip:    --------返回按钮属于需要返回到按钮
    viewController.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//
//    //设置返回按钮颜色
//    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    //设置标题颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // 调用系统默认做法,因为只有系统才知道怎么做push
    [super pushViewController:viewController animated:animated];
}






@end
