//
//  JRoomDetailedModel.m
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JRoomDetailedModel.h"
#import "NSString+YYAdd.h"
@implementation JRoomDetailedModel

- (CGFloat)contentHeiht
{
    CGFloat margin  = 10;
    
    CGSize size = CGSizeMake(kScreenWidth - 3 * margin, MAXFLOAT);
    
    return [_content sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByWordWrapping].height + 2 * margin;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeFloat:_contentHeiht forKey:@"contentHeiht"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _content = [aDecoder decodeObjectForKey:@"content"];
        _contentHeiht = [aDecoder decodeFloatForKey:@"contentHeiht"];
    }
    
    return self;
}

@end
