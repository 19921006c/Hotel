//
//  MyReaderHeaderCollectionReusableView.m
//  DoctorPlatForm
//
//  Created by silent on 15/12/31.
//  Copyright © 2015年 songzm. All rights reserved.
//

#import "MyReaderHeaderCollectionReusableView.h"
@interface MyReaderHeaderCollectionReusableView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineImageViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MyReaderHeaderCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    self.topLineImageViewHeight.constant = 0.5;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    if (index == 0) {
        _label.text = @"Done:   (long press go to the next)";
    }else{
        _label.text = @"Todo:   (long press go to the next)";
    }
}
@end
