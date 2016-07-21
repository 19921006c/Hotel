//
//  JYYCacheTool.h
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYYCacheTool : NSObject

/**
 *  set
 */
+ (void)setObject:(id)object forKey:(NSString *)key;


/**
 *  get
 */
+ (id)objectForKey:(NSString *)key;

/**
 *  删数据
 */
+ (void)removeObjectForKey:(NSString *)key;

@end
