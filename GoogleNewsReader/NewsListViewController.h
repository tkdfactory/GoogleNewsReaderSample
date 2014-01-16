//
//  NewsListViewController.h
//  GoogleNewsReader
//
//  Created by tkd on 2013/12/12.
//  Copyright (c) 2013年 tkd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) NSString* keyword;

@end
