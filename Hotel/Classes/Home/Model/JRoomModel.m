//
//  JRoomModel.m
//  Hotel
//
//  Created by J on 16/7/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JRoomModel.h"

@implementation JRoomModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_roomName forKey:@"roomName"];
    [aCoder encodeObject:_roomId forKey:@"roomId"];
    [aCoder encodeInteger:_selectedType forKey:@"selectedType"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _roomName = [aDecoder decodeObjectForKey:@"roomName"];
        _roomId = [aDecoder decodeObjectForKey:@"roomId"];
        _selectedType = [aDecoder decodeIntegerForKey:@"selectedType"];
    }
    return self;
}

@end
