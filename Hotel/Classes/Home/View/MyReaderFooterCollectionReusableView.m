//
//  MyReaderFooterCollectionReusableView.m
//  DoctorPlatForm
//
//  Created by silent on 15/12/31.
//  Copyright © 2015年 songzm. All rights reserved.
//

#import "MyReaderFooterCollectionReusableView.h"

@interface MyReaderFooterCollectionReusableView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineImageHeight;

@end

@implementation MyReaderFooterCollectionReusableView

- (void)awakeFromNib {
    
    self.bottomLineImageHeight.constant = 0.5;
    // Initialization code
}

@end
