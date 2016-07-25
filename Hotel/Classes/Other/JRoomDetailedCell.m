//
//  JRoomDetailedCell.m
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JRoomDetailedCell.h"

@interface JRoomDetailedCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;


@end

@implementation JRoomDetailedCell

static NSString *const identifier = @"JRoomDetailedCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    JRoomDetailedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setContnent:(NSString *)contnent
{
    _contnent = contnent;
    
    _contentLabel.text = contnent;
}

@end
