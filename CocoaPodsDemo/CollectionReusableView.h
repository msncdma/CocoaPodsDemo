//
//  CollectionReusableView.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView

@property(nonatomic, strong)UIView *baseView;
@property(nonatomic, strong)UIImageView *arrowView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIButton *button;

@end
