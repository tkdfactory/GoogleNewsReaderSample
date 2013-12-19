//
//  NewsListViewController.m
//  GoogleNewsReader
//
//  Created by tkd on 2013/12/12.
//  Copyright (c) 2013年 tkd. All rights reserved.
//

#import "NewsListViewController.h"

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
    
    self.view.backgroundColor = [UIColor greenColor];
    
    //戻るボタンを生成
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnBack.frame = CGRectMake(200, 100, 100, 50);
    [btnBack setTitle:@"戻るボタン" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickBtnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
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
