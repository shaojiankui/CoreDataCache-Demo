//
//  NewsCell.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//


#import "NewsCell.h"
#import "UIImageView+WebCache.h"
@implementation NewsCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

-(void)setContent:(News*)info
{
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl]];
    _newsTitle.text = info.title;
    _newsDescr.text = info.descr;
    if ([info.islook isEqualToString:@"1"]) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

@end
