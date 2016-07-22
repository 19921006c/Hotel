//
//  JRoomDetailedModel.h
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JRoomDetailedModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) CGFloat contentHeiht;

@end
