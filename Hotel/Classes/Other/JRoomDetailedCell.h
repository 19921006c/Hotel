//
//  JRoomDetailedCell.h
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRoomDetailedCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *contnent;

@property (nonatomic, assign) NSInteger index;
@end
