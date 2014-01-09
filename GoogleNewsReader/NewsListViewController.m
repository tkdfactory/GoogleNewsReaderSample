//
//  NewsListViewController.m
//  GoogleNewsReader
//
//  Created by tkd on 2013/12/12.
//  Copyright (c) 2013年 tkd. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsLoader.h"
#import "News.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //テーブルビューを生成
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    
    //APIを試しに叩いてみる
    NSArray *newsArray = [NewsLoader load:self.keyword pageNum:1];
    
    for (News *news in newsArray) {
        NSLog(@"%@",news.title);
    }
    
}

//戻るボタンクリック
- (void)clickBtnBack
{
    //ナビゲーションコントローラーに戻れと指示を出す
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
