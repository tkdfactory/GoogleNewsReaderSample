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

@interface NewsListViewController (){
    NSArray *newsArray;
}

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
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
    //APIを叩いてニュースを取得する
    newsArray = [NewsLoader load:self.keyword pageNum:1];
    
}

//セクションごとの行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (newsArray==nil) {
        return 0;
    }
    
    return newsArray.count;
}

//セルを生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cellをキャッシュするときのキー
    static NSString* cellId = @"aaa";
    
    //cellがキャッシュされていれば、再利用する。
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil) {
        //cellがなければインスタンスを生成する
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    //このrowで表示するニュース
    News *news = [newsArray objectAtIndex:indexPath.row];
    
    //セルの中身をセット
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.content;
    cell.detailTextLabel.numberOfLines = 5;
    //画像
    if (news.imageUrl != nil) {
        NSData* data = [NSData dataWithContentsOfURL:news.imageUrl];
        cell.imageView.image = [[UIImage alloc] initWithData:data];
    }
    
    return cell;
}

//行の高さを返す
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
