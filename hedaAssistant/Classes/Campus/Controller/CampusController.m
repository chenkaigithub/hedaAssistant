//
//  CampusController.m
//  hedaAssistant
//
//  Created by bear on 16/3/25.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "CampusController.h"
#import "XCSearchCell.h"
#import "XCMenuCell.h"
#import "NewsDetailController.h"
#import "MJRefresh.h"
#import "UINavigationItem+custom.h"
#import "News.h"
#import "XCNewsCell.h"


@interface CampusController ()
@property(nonatomic,strong)NSMutableArray *newsList;


@property (nonatomic, strong) UISearchBar *searchBar;


@end

@implementation CampusController

static NSString * const reuseIdentifier = @"campus";

- (void)viewDidLoad {


    self.tableView.estimatedRowHeight = 40;
//
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc]init];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.tableView addFooterWithTarget:self action:@selector(loadMore)];

    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-60, 44)];
    _searchBar.placeholder=@"奇趣  新闻  通知";

}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


        if (scrollView.contentOffset.y<50) {
            [self.navigationItem setMyTitle:@"校园"];
            return;
        }else{
            self.navigationItem.titleView=self.searchBar;
        }
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailController *newsDetailVc=[[NewsDetailController alloc]init];
    newsDetailVc.news=self.newsList[indexPath.row];


    [self.navigationController showViewController:newsDetailVc sender:nil];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {

        return 2;
    }else{
        return self.newsList.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                XCSearchCell *cell=[XCSearchCell cellWithTableView:tableView];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 1:{
                XCMenuCell *cell=[XCMenuCell cellWithTableView:tableView];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;

            }
            default:
                break;
        }
        

    }else{
        XCNewsCell *cell=[XCNewsCell cellWithTableView:tableView];
        cell.news=self.newsList[indexPath.row];

        return cell;

    }




    XCNewsCell *cell=[XCNewsCell cellWithTableView:tableView];
    cell.news=self.newsList[indexPath.row];

    return cell;



}



#pragma mark 懒加载数据
-(NSMutableArray *)newsList{
    if (_newsList==nil) {
        NSURL *url=[[NSBundle mainBundle] URLForResource:@"newsList" withExtension:@"plist"];
        _newsList =[NSMutableArray arrayWithContentsOfURL:url];

        NSMutableArray *arrM=[NSMutableArray array];

        for (NSDictionary *dict in  _newsList) {
            News *model=[News newsWithDict:dict];
            [arrM addObject:model];
        }
        NSLog(@"---%@",arrM);

        _newsList=arrM;

    }
    return _newsList;
}



-(void)loadMore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [_newsList addObjectsFromArray:_newsList];
        [self.tableView reloadData];

        [self.tableView footerEndRefreshing];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50;
        }else{
            return SCREEN_WIDTH*(134/273.0);
        }
    }else{
        return 124;
    }
}
@end
