//
//  JMainTabBarController.m
//  Hotel
//
//  Created by J on 16/7/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JMainTabBarController.h"
#import "JMainNavigationController.h"
#import "JHomeViewController.h"
@interface JMainTabBarController (){
    JHomeViewController *homeVc;
}
@end

@implementation JMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JHomeViewController *vc = [[JHomeViewController alloc]init];
    
    self.tabBar.tintColor = [UIColor blueColor];
    vc.tabBarItem.title = @"home";
    vc.tabBarItem.image = [UIImage imageNamed:@"tabbar_service_normal"];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_service_selected"];
    self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBar.tintColor = [UIColor blueColor];
    JMainNavigationController *nav = [[JMainNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    // Do any additional setup after loading the view.
}



@end
