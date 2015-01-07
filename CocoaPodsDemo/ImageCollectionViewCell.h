//
//  ImageCollectionViewCell.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell{
    UIImageView *overlayView;
}

@property(nonatomic,setter = setFileModel:)FileModel *fileModel;

@property (nonatomic) BOOL showSelectedStyle;

@end
