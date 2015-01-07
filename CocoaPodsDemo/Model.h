//
//  Model.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//
@class FileModel;
//文件类型类型
typedef NS_ENUM(int, FileType){
    FileTypeDoc = 0,  //文档
    FileTypeImage,     //图片
    FileTypeVideo,    //视频
    FileTypeMusic,    //音乐
    FileTypeOthers    //其它
};


@protocol DidSelectRow  <NSObject>

//选择某项
- (void)didSelectedItem:(FileModel*)picModel withIndexPath:(NSIndexPath *)indexPath;
//取消选择某项
- (void)didDeSelectedItem:(FileModel *)picModel withIndexPath:(NSIndexPath *)indexPath;

@end

