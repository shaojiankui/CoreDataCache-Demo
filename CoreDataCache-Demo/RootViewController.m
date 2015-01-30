//
//  RootViewController.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "RootViewController.h"
#import "NewsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildTab];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

-(void)buildTab{
    NewsViewController *news = [[NewsViewController alloc]init];
    news.tabBarItem.title=@"资讯";
    
    self.delegate = self;
    self.viewControllers = @[news];
    self.selectedViewController = news;
    self.title = @"资讯";
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
}


@end
