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

@end

@implementation MyReaderHeaderCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    self.topLineImageViewHeight.constant = 0.5;
}

@end
