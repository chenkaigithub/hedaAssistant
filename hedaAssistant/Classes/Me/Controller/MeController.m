//
//  MeController.m
//  hedaAssistant
//
//  Created by bear on 16/3/31.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "MeController.h"
#import "MeHeaderView.h"
#import "SettingController.h"
#import "UIBarButtonItem+XCC.h"
#import "UIScrollView+ScalableCover.h"
#import "AppDelegate.h"

@interface MeController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.plsitName=@"MeSet";

    MeHeaderView *header=[[MeHeaderView alloc]init];

    header.frame=CGRectMake(0, 0, SCREEN_WIDTH,200);

    self.tableView.tableFooterView=[[UITableViewHeaderFooterView alloc]init];

    self.tableView.tableHeaderView=header;





    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"ic_navigation_setting_normal"] highImage:[UIImage imageNamed:@"ic_navigation_setting_normal"] target:self action:@selector(popSetting)];

    self.navigationItem.rightBarButtonItem=settingBtn;
    [self setCoverImage];



}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


    [UIView transitionWithView:self.navigationController.navigationBar duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clear_bg"] forBarMetrics:UIBarMetricsDefault];



    } completion:nil];
}





-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forBarMetrics:UIBarMetricsDefault];


}




- (void)setCoverImage
{


    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    NSString *imageName = @"mebg";
    if (screenWidth.intValue < 400) {
        imageName = [NSString stringWithFormat:@"%@", imageName];;
    }

    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
        imageName = [NSString stringWithFormat:@"%@-dark", imageName];
    }

    if (!self.tableView.scalableCover) {
        [self.tableView addScalableCoverWithImage:[UIImage imageNamed:imageName]];
    } else {
        self.tableView.scalableCover.image = [UIImage imageNamed:imageName];
    }
}




-(void)popSetting{

    [self.navigationController pushViewController:[[SettingController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];

    
}





@end
