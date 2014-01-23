//
//  DetailViewController.h
//  GoogleNewsReader
//
//  Created by tkd on 2014/01/23.
//  Copyright (c) 2014年 tkd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, retain) NSURL *url;

@end
