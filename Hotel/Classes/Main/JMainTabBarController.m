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
#import "JNoteViewController.h"
@interface JMainTabBarController (){
    JHomeViewController *homeVc;
    JNoteViewController *noteVc;
}
@end

@implementation JMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    homeVc = [[JHomeViewController alloc]init];
    noteVc = [[JNoteViewController alloc]init];
    
    [self addOneChildController:homeVc title:@"home" norImage:@"tabbar_service_normal" selectedImage:@"tabbar_service_selected"];
    [self addOneChildController:noteVc title:@"note" norImage:@"tabbar_message_normal" selectedImage:@"tabbar_message_selected"];

    // Do any additional setup after loading the view.
}

- (void)addOneChildController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage
{
    //设置tabbar图片不被渲染
    self.tabBar.tintColor = [UIColor blueColor];
    //设置tabBar背景颜色不被改变
    self.tabBar.backgroundColor = [UIColor whiteColor];
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:norImage];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    JMainNavigationController  *nav = [[JMainNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}



@end
