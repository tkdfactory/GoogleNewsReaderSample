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
#import "DetailViewController.h"

@interface NewsListViewController (){
    NSMutableArray *newsArray;
    UITableView *tableView;
    int pageNum;
    UIRefreshControl *refreshControl;
    
    dispatch_queue_t queueGlobal;
    dispatch_queue_t queueMain;
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
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    //UIRefreshControl
    refreshControl = [[UIRefreshControl alloc] init];
    [tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    //APIを叩いてニュースを取得する
    pageNum = 1;
    newsArray = [[NSMutableArray alloc] init];
    [newsArray addObjectsFromArray:[NewsLoader load:self.keyword pageNum:pageNum]];
    
    //重い処理をするキュー
    queueGlobal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //画面の処理をするキュー
    queueMain = dispatch_get_main_queue();
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
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        dispatch_async(queueGlobal, ^{
            NSData* data = [NSData dataWithContentsOfURL:news.imageUrl];
            
            dispatch_async(queueMain, ^{
                cell.imageView.image = [[UIImage alloc] initWithData:data];
                [cell layoutSubviews];
            });
        });
    }else{
        cell.imageView.image = nil;
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

//セル選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = [newsArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",news.title);
    
    
    DetailViewController *vcDetail = [[DetailViewController alloc] init];
    vcDetail.url = news.url;
    
    [self.navigationController pushViewController:vcDetail animated:YES];
}

//もっと見る
- (void)tableView:(UITableView *)aTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= newsArray.count - 1) {
        
        dispatch_async(queueGlobal, ^{
            //ページを１つ増やす
            pageNum++;
            //APIを叩いてニュースリストに追加
            [newsArray addObjectsFromArray:[NewsLoader load:self.keyword pageNum:pageNum]];
            
            dispatch_async(queueMain, ^{
                //テーブルビューを再描画
                [tableView reloadData];
            });
        });
    }
}

//再読み込み
- (void)refresh
{
    //ページ番号を戻す
    pageNum = 1;
    //ニュースのリストも再作成
    newsArray = [[NSMutableArray alloc] init];
    //ニュースを読み込む
    [newsArray addObjectsFromArray:[NewsLoader load:self.keyword pageNum:pageNum]];
    
    //クルクルを止める
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
