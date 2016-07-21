//
//  JMainNavigationController.m
//  Hotel
//
//  Created by J on 16/7/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JMainNavigationController.h"

@interface JMainNavigationController ()

@end

@implementation JMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //不是栈底控制器，隐藏tabbar
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

@end
