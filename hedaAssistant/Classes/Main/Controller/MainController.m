//
//  MainController.m
//  新浪微博
//
//  Created by 40  on 15/11/23.
//  Copyright © 2015年 bear. All rights reserved.
//

#import "MainController.h"
#import "TableController.h"
#import "NewsController.h"
#import "MeController.h"
#import "CampusController.h"
#import "UIBarButtonItem+Create.h"
#import "XCLeftView.h"


@interface MainController ()<XCTabBarDelegate>
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, weak) UIView *leftView;

@property (nonatomic, strong) id popDelegate;


@property (nonatomic, assign) CGPoint prePoint;

@end

@implementation MainController


- (void)viewDidLoad {

    [super viewDidLoad];


    
    self.view.layer.shadowOffset=CGSizeMake(-6, -10);

    self.view.layer.shadowOpacity=0.2;




//    self.navigationBackgroundColor=COLOR(12, 165, 219, 0.2);
//    [self.navigationController.navigationBar  ];


    NSMutableArray *arrM=[NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {

        UIBarButtonItem *pullLeft = [UIBarButtonItem itemRoundWithImage:   [UIImage imageNamed:@"ic_navigation_more_normal"] highImage:[UIImage imageNamed:@"ic_navigation_more_press"] target:self action:@selector(pullLeft)];
        
        

        [arrM addObject:pullLeft];

    }

    self.leftBarButtonItems=arrM;





    self.childControllerAndIconArr=@[
                                     @{
                                         VIEWCONTROLLER : [[TableController alloc]init],  //控制器
                                         NORMAL_ICON : @"icon_classTable",                 //正常状态的Icon 名称
                                         SELECTED_ICON : @"icon_classTable_selected",       //选中状态的Icon 名称
                                         TITLE : @"表"                                       //Nav和Tab的标题
                                         },
                                     @{
                                         VIEWCONTROLLER : [[CampusController alloc]init],
                                         NORMAL_ICON : @"icon_discover",
                                         SELECTED_ICON : @"icon_discover_selected",
                                         TITLE : @"校园"
                                         },
                                     @{
                                         VIEWCONTROLLER : [[MeController alloc]initWithStyle:UITableViewStyleGrouped],
                                         NORMAL_ICON : @"icon_me",
                                         SELECTED_ICON : @"icon_me_selected",
                                         TITLE : @"我"
                                         }
                                     ];




    UISwipeGestureRecognizer *leftRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    leftRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;

   [self.view  addGestureRecognizer:leftRecognizer];
    UISwipeGestureRecognizer *rightRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];


    [self.view  addGestureRecognizer:rightRecognizer];



}





-(void)swip:(UISwipeGestureRecognizer * )swipeGestureRecognizer{


    if (swipeGestureRecognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"======left");



        [self close];

    }

    if (swipeGestureRecognizer.direction==UISwipeGestureRecognizerDirectionRight) {



        CGPoint point=       [swipeGestureRecognizer locationInView:self.view];

        NSLog(@"%@",NSStringFromCGPoint(point));

        [self open];


    }
}


-(void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.x=0;
        self.leftView.x=-SCREEN_WIDTH+100;

        [self.view.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:)];


    }];

    for (UIViewController *vc in self.viewControllers) {
        [vc.view setUserInteractionEnabled:YES];

    }

}


-(void)open{

    [UIView animateWithDuration:0.3 animations:^{

        self.view.x=SCREEN_WIDTH-100;
        self.leftView.x=0;
        [self.view.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:)];

    }];
    for (UIViewController *vc in self.viewControllers) {
        [vc.view setUserInteractionEnabled:NO];
    }






}


-(void)pullLeft{
    self.isOpen=!self.isOpen;



        if (!self.isOpen) {
            [self close];

        }else{
            [self open];
        }


}






-(UIView *)leftView{
    if (!_leftView) {
        XCLeftView *leftView=[[[NSBundle mainBundle]loadNibNamed:@"XCLeftView" owner:nil options:nil]lastObject];
        leftView.frame=CGRectMake(-SCREEN_WIDTH+100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:leftView];
        _leftView=leftView;
        
    }
    return _leftView;
}




@end
