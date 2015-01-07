//
//  CollectionReusableView.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initView];
    }
    return self;
}

- (void)_initView{
   
    _baseView = [[UIView alloc]initWithFrame:self.bounds];
    _baseView.backgroundColor = [UIColor clearColor];
  
    _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    [_baseView addSubview:_arrowView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_arrowView.left + 20, 0, kScreenWidth - 20, 40)];
    [_baseView addSubview:_titleLabel];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [_baseView addSubview:_button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    lineImage.clipsToBounds = NO;
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [_baseView addSubview:lineImage];
    
    [self addSubview:_baseView];
    
}



@end

