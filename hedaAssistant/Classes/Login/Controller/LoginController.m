//
//  LoginController.m
//  hedaAssistant
//
//  Created by bear on 15/11/29.
//  Copyright © 2015年 bear. All rights reserved.
//

#import "LoginController.h"
#import "MainController.h"
#import "KeychainItemWrapper.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "User.h"
#import "AppDelegate.h"




#define CONTENTENT_WIDTH   (SCREEN_WIDTH)

@interface LoginController ()
@property(nonatomic)UITextField *uid;
@property (nonatomic)UITextField *pwd;
@property (nonatomic, weak) UIButton *loginBtn;




@property (nonatomic, strong) KeychainItemWrapper *keychain;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
    [self.navigationController.navigationBar setBarTintColor:COLOR(12, 165, 219, 0.5)];

}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];

    self.keychain=[[KeychainItemWrapper alloc] initWithIdentifier:@"hedaUser" accessGroup:nil];
    self.uid.text=[_keychain objectForKey:(id)kSecAttrAccount];
    self.pwd.text=[_keychain objectForKey:(id)kSecValueData];




}


-(void)setUI{


    CGFloat startY=64;

    UIImageView *headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 80+startY, 100, 100)];
    headImgView.center=CGPointMake(SCREEN_WIDTH/2,  80+30+startY);
    
    headImgView.image=[UIImage imageNamed:@"headImg"];
    [self.view addSubview:headImgView];

    
    _uid=[[UITextField alloc]initWithFrame:CGRectMake(40, 80+100+startY, CONTENTENT_WIDTH-80, 44)];

    [_uid setAlpha:0.8f];
    [_uid setBorderStyle:UITextBorderStyleRoundedRect];
    [_uid setPlaceholder:@"请输入工号/学号:"];
    [_uid becomeFirstResponder];
    _uid.backgroundColor=COLOR(227, 227, 227, 1);

    _pwd=[[UITextField alloc]initWithFrame:CGRectMake(40, 80+144+startY, CONTENTENT_WIDTH-80, 44)];
    
    [_pwd setAlpha:0.8f];
    [_pwd setPlaceholder:@"密码"];
    [_pwd setKeyboardType:UIKeyboardTypeAlphabet];
    [_pwd setBorderStyle:UITextBorderStyleRoundedRect];
    [_pwd setSecureTextEntry:YES];
    _uid.keyboardType=UIKeyboardTypeNumberPad;
    _pwd.keyboardType=UIKeyboardAppearanceDefault;
    _pwd.backgroundColor=COLOR(227, 227, 227, 1);

    
    
    [self.view addSubview:_uid];
    [self.view addSubview:_pwd];
    UIButton *loginButton =[[UIButton alloc]initWithFrame:CGRectMake(40, 80+44*2+120+startY, CONTENTENT_WIDTH-80, 44)];

    loginButton.backgroundColor=[UIColor brownColor];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];


    [loginButton setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forState:UIControlStateNormal];

    loginButton.backgroundColor=[UIColor lightGrayColor];
    
    [loginButton setAlpha:0.8f];
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn=loginButton;

    [self.view addSubview:loginButton];

    
    
}




-(void)loginClick{
//    XCLog(@"LoginClick");






    [self.view endEditing:YES];

    self.loginBtn.enabled=NO;


    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText=@"登录中";
    hub.dimBackground=YES;

        NSString *uid=_uid.text;
        NSString *pwd=_pwd.text;


    //保存帐号
    [_keychain setObject:uid forKey:(id)kSecAttrAccount];

    //保存密码
    [_keychain setObject:pwd forKey:(id)kSecValueData];


    

    NSString *serviceName=@"User.GetBaseInfo";
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",ApiHost,serviceName];

    NSDictionary *parmas = @{ @"user_id":uid, @"user_pwd":pwd};

    [XCHttpTool GET:urlStr parameters:parmas success:^(id responseObject) {


        //获取用户字典
        NSDictionary *userInfo=responseObject[@"data"][@"info"];


        User *user =[User userWithDict:userInfo];

        //保存到全局
        ((AppDelegate *)[UIApplication sharedApplication].delegate).user_id=user.user_id;

        //保存用户信息到归档
        [NSKeyedArchiver archiveRootObject:user toFile:[self getFilePath]];

        //切换控制器
        MainController *mainVc=[[MainController alloc]init];
        self.view.window.rootViewController=mainVc;

        [hub hide:YES afterDelay:2];



    } failure:^(NSError *error) {

        hub.mode=MBProgressHUDModeCustomView;

        hub.labelText=@"用户名或密码错误";

        [hub hide:YES afterDelay:1];
        XCLog(@"falied");
    }];





}


-(NSString *)getFilePath{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath=[docPath stringByAppendingPathComponent:@"user.data"];
    NSLog(@"-------%@",filePath);
    return filePath;
}


@end
