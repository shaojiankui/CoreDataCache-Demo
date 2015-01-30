//
//  NewsViewController.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "News.h"

#import "CacheManager.h"
#import "CoreDataManager.h"
#import "NSString+ArrayValue.h"
#import "UIImageView+WebCache.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"资讯";
    
    _items = [NSMutableArray  array];
}


- (IBAction)buttonTouched:(id)sender {
    [self writeDate];
}
-(void)writeDate
{
    CoreDataManager *manager = [CoreDataManager shareManager];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //读取信息，我在这里写成本地的了，一般的都是从网上获取数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"News" ofType:@"json"];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [data arrayValue];
    for (NSDictionary *dict in array) {
        News *info = [[News alloc]initWithDictionary:dict];
        [_items addObject:info];
    }
    //把数据写到数据库
    [manager insertCoreDataModel:@"News" DataArray:_items];
    [self.myTableView reloadData];
}

#pragma mark -
#pragma -mark TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NewsCell";
    [tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    //[tableView registerClass:[NewsCell class] forCellReuseIdentifier:CellIdentifier];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    News *item =_items[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imgurl]];
    cell.textLabel.text =item.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
