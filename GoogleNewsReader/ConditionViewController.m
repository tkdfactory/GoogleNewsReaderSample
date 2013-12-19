//
//  ConditionViewController.m
//  GoogleNewsReader
//
//  Created by TakuroTsukada on 2013/12/12.
//  Copyright (c) 2013年 TakuroTsukada. All rights reserved.
//

#import "ConditionViewController.h"
#import "NewsListViewController.h"

@interface ConditionViewController ()

@end

@implementation ConditionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//画面生成時に呼ばれるメソッド
- (void)viewDidLoad
{
    [super viewDidLoad];

    //背景を赤に変更
    self.view.backgroundColor = [UIColor redColor];
    
    //検索ボタンを生成
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSearch.frame = CGRectMake(200, 100, 100, 50);
    [btnSearch setTitle:@"検索ボタン" forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(clickBtnSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
}

//ボタンクリック
- (void)clickBtnSearch
{
    //次の画面のインスタンスを生成
    NewsListViewController *vcNewsList = [[NewsListViewController alloc] init];
    //ナビゲーションコントローラーにプッシュ！
    [self.navigationController pushViewController:vcNewsList animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
