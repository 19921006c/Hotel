//
//  JRoomModel.h
//  Hotel
//
//  Created by J on 16/7/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SelectedTypeYes = 1,
    SelectedTypeNone = 2,
} SelectedType;

@interface JRoomModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *roomName;

@property (nonatomic, copy) NSString *roomId;

/**
 *     :   done
 *  2   :   todo
 */
@property (nonatomic, assign) SelectedType selectedType;
@end
