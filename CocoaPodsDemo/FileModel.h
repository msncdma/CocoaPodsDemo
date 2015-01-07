//
//  FileModel.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/4.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

//#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (nonatomic ,assign)FileType fileType;       //单元格名称
@property (nonatomic ,strong)NSString *fileName;       //文件名
@property (nonatomic ,strong)NSDate *fileTime;         //文件时间
@property (nonatomic ,assign)float fileSize;           //文件大小
@property (nonatomic ,strong)UIImage *thumbnail;       //缩略图
@property (nonatomic ,strong)NSURL *fileImageUrl;   //文件图片地址

@end
