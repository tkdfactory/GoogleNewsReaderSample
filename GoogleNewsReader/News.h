//
//  News.h
//  GoogleNewsReader
//
//  Created by tkd on 2014/01/09.
//  Copyright (c) 2014年 tkd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSURL* url;
@property (nonatomic, retain) NSURL* imageUrl;
@property (readwrite) CGFloat imageWidth;
@property (readwrite) CGFloat imageHeight;

@end
