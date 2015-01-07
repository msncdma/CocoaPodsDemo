//
//  FileCell.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/4.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"

@interface FileCell : UITableViewCell{
    CGFloat _cellHeight;
    FileModel *_fileModel;
}

@property (strong, nonatomic)  UILabel *fileNameLabel;

@property (strong, nonatomic)  UILabel *filetimeLabel;

@property (strong, nonatomic)  UILabel *fileSize;

@property (strong, nonatomic)  UIImageView *filePhoto;

@property (strong, nonatomic)  UIImageView *imageLine;

@property (strong, nonatomic) FileModel *fileModel;

- (void)setFrame1;
@end
