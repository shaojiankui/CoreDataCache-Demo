//
//  NewsViewController.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsViewController : BaseViewController
{
    NSMutableArray *_items;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
