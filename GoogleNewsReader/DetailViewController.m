//
//  DetailViewController.m
//  GoogleNewsReader
//
//  Created by tkd on 2014/01/23.
//  Copyright (c) 2014年 tkd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    UIWebView *webView;
    UIToolbar *toolbar;
}

@end

@implementation DetailViewController

int const TOOL_BAR_HEIGHT = 48;

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

    //webViewを生成
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //toolbarを生成
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -  TOOL_BAR_HEIGHT , self.view.frame.size.width, TOOL_BAR_HEIGHT)];
    [self.view addSubview:toolbar];
    
    //戻るボタン
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:101
                                target:self
                                action:@selector(clickBtnBack)];
    btnBack.enabled = NO;
    
    //進むボタン
    UIBarButtonItem *btnForward = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:102
                                target:self
                                action:@selector(clickBtnForward)];
    btnForward.enabled = NO;
    
    //更新ボタン
    UIBarButtonItem *btnReload = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                   target:self
                                   action:@selector(clickBtnReload)];
    
    //スペース
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:nil];
    
    //ボタンの配列を生成
    NSArray *btnArray = [NSArray arrayWithObjects:btnBack, space, btnForward, space, btnReload, space, nil];
    toolbar.items = btnArray;
    
    //NSURLRequestを生成
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    //NSURLRequestを読み込む
    [webView loadRequest:request];
}

//読み込み完了
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    ((UIBarButtonItem*)[toolbar.items objectAtIndex:0]).enabled = aWebView.canGoBack;
    ((UIBarButtonItem*)[toolbar.items objectAtIndex:2]).enabled = aWebView.canGoForward;
}

//戻るボタンクリック
-(void)clickBtnBack
{
    [webView goBack];
}

//進むボタンクリック
-(void)clickBtnForward
{
    [webView goForward];
}

//更新ボタンクリック
-(void)clickBtnReload
{
    [webView reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
