//
//  SafariActivity.m
//  GoogleNewsReader
//
//  Created by TakuroTsukada on 2014/02/06.
//  Copyright (c) 2014年 TakuroTsukada. All rights reserved.
//

#import "SafariActivity.h"

@implementation SafariActivity

- (NSString *)activityType
{
    return @"Safari";
}

- (NSString *)activityTitle
{
    return @"Safariで開く";
}

- (UIImage *)activityImage
{
    //UIImage *icon = [UIImage imageNamed:@"Safari.png"];
    //return icon;
    return nil;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return TRUE;
}


- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    
    [[UIApplication sharedApplication] openURL:self.url];
    
}


@end
