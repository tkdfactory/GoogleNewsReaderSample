//
//  ConditionViewController.m
//  GoogleNewsReader
//
//  Created by tkd on 2013/12/12.
//  Copyright (c) 2013年 tkd. All rights reserved.
//

#import "ConditionViewController.h"
#import "NewsListViewController.h"

@interface ConditionViewController (){
    UITextField *tfKeyword;
}

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

    //背景を白に変更
    self.view.backgroundColor = [UIColor whiteColor];
    
    //検索ボタンを生成
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSearch.frame = CGRectMake(230, 100, 100, 50);
    [btnSearch setTitle:@"検索" forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(clickBtnSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
    
    //テキストフィールドを生成
    tfKeyword = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 200, 50)];
    tfKeyword.borderStyle = UITextBorderStyleRoundedRect;
    tfKeyword.textColor = [UIColor blackColor];
    tfKeyword.placeholder = @"キーワード";
    tfKeyword.clearButtonMode = UITextFieldViewModeAlways;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    tfKeyword.text = [ud stringForKey:@"keyword"];
    
    [self.view addSubview:tfKeyword];
    
    //UIViewの説明
    /*
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(150, 100, 150, 200)];
    blueView.backgroundColor = [UIColor blueColor];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.frame = CGRectMake(120, 90, 50, 50);
    greenView.backgroundColor = [UIColor greenColor];

    [blueView addSubview:greenView];
    [self.view addSubview:blueView];
    */

}

//ボタンクリック
- (void)clickBtnSearch
{
    //次の画面のインスタンスを生成
    NewsListViewController *vcNewsList = [[NewsListViewController alloc] init];
    //キーワードを次の画面へ渡す
    vcNewsList.keyword = tfKeyword.text;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:tfKeyword.text forKey:@"keyword"];
    [ud synchronize];//すぐ反映させる場合
    
    //ナビゲーションコントローラーにプッシュ！
    [self.navigationController pushViewController:vcNewsList animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
