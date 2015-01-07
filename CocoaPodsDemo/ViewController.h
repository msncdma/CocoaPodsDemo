//
//  ViewController.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/11/20.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Masonry.h"
#import "PPiFlatSegmentedControl.h"
#import "FileTableView.h"
#import "ImageCollectionView.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef enum kFileStyle{
    kRecentlyStyle = 0,
    kLocalStyle = 1
}kFileStyle;

@interface ViewController : BaseViewController <DidSelectRow> {
    PPiFlatSegmentedControl *_segmentedControl;
    UIView *_baseView;         //最近（文件）选择底部视图
    UIView *_localBaseView;    //本机（文件）选择底部视图
    
   
    UIImageView *moveView;        //最近（文件）选择移动视图
    UIImageView *LocalMoveView;   //本机（文件）选择移动视图
    
    //最近 - 文件列表 （全部，文档，图片，视频，音乐）
    FileTableView *_baseTableView;
    ImageCollectionView *_baseCollectionView;
    
    //本机 - 文件列表 （文档，相机，视频，音乐，其它）
    ImageCollectionView *_photoCollectionView;


    BOOL _isEditing;  //是否在编辑
    
    BOOL _reloadFlag;
    
    
    double _fileSize;   //所选文件大小
    
    //发送视图
    UIView *_sendView;       //发送基视图
    UILabel *_sizeLabel;    //文件大小
    UIButton *_sendButton;  //发送按钮
}

@property (nonatomic, strong)PPiFlatSegmentedControl *segmentedControl;
@property (nonatomic, strong)UIView *baseView;
@property (nonatomic, strong)UIView *localBaseView;
@property (nonatomic, strong)UITableView *baseTableView;

@property (nonatomic ,strong)NSMutableDictionary *dataDic;  //存每个分组的数据
@property (nonatomic ,strong)NSMutableArray *titleDataArray;//存每个分组的标题
@property (nonatomic ,strong)NSMutableArray *selectArr; //选中的


//本地相册
@property (nonatomic,strong) NSMutableArray  *groupArrays; //相册组数据
@property (nonatomic,strong) NSMutableArray  *imageArrays; //相册数据
@property (nonatomic,strong) NSMutableArray  *videoArrays;
@property (nonatomic,strong) NSMutableArray *imageTitleArray; //相册标题数据
@property (nonatomic,strong) NSMutableDictionary *imageGroup; //相册标题数据

@end

