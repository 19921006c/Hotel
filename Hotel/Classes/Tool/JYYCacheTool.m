//
//  JYYCacheTool.m
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JYYCacheTool.h"
#import "YYCache.h"
static NSString *cacheName = @"JHomePageData";

@implementation JYYCacheTool

+ (void)setObject:(id)object forKey:(NSString *)key
{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    
    [cache setObject:object forKey:key];
}

+ (id)objectForKey:(NSString *)key
{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    
    return [cache objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key
{
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    
    [cache removeObjectForKey:key];
    

}

@end
