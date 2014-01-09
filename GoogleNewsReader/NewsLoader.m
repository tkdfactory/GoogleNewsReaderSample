//
//  NewsLoader.m
//  GoogleNewsReader
//
//  Created by tkd on 2014/01/09.
//  Copyright (c) 2014年 tkd. All rights reserved.
//

#import "NewsLoader.h"
#import "News.h"

@implementation NewsLoader

+(NSArray*)load:(NSString *)keyword pageNum:(int)page
{
    //URLを生成
    NSString *encodedKeyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//URLエンコード（ホントは足りない）
    int start = (page-1)*4;//スタートページ番号
    NSString *urlStr = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&start=%d&q=%@", start, encodedKeyword];//URLを生成
    NSLog(@"%@",urlStr);
    
    //リクエストを投げる
    NSURL *url = [NSURL URLWithString:urlStr];//NSURLを生成
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//NSURLRequestを生成 POSTの場合は別の方法がある
    
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];//今回は同期的に処理する（ホントは非同期で）
    
    //結果をJSONにシリアライズ
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    
    NSDictionary *responseData = [json objectForKey:@"responseData"];
    NSArray *resultsArray = [responseData objectForKey:@"results"];
    
    
    //Newsのインスタンスを生成
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSDictionary *resultDic in resultsArray) {
        News *news = [[News alloc] init];
        news.title = [resultDic objectForKey:@"titleNoFormatting"];
        news.content = [resultDic objectForKey:@"content"];
        news.url = [NSURL URLWithString:[resultDic objectForKey:@"unescapedUrl"]];
        
        NSDictionary *imageDic = [resultDic objectForKey:@"image"];
        if (imageDic!=nil) {
            news.imageHeight = [[imageDic objectForKey:@"tbHeight"] floatValue];
            news.imageUrl = [NSURL URLWithString:[imageDic objectForKey:@"tbUrl"]];
            news.imageWidth = [[imageDic objectForKey:@"tbWidth"] floatValue];
        }
        
        [result addObject:news];
    }

    return result;
}

@end
