//
//  NewsLoader.h
//  GoogleNewsReader
//
//  Created by tkd on 2014/01/09.
//  Copyright (c) 2014年 tkd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsLoader : NSObject

+(NSArray*)load:(NSString *)keyword pageNum:(int)page;

@end
