//
//  MyReaderCollectionCell.m
//  DoctorPlatForm
//
//  Created by silent on 15/12/31.
//  Copyright © 2015年 songzm. All rights reserved.
//

#import "MyReaderCollectionCell.h"

@implementation MyReaderCollectionCell

- (void)awakeFromNib {
    // Initialization code
    self.label.layer.borderWidth = .5;
    self.label.layer.borderColor = [[UIColor blackColor] CGColor];
}

@end
