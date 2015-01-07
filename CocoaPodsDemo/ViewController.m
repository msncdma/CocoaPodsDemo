//
//  ViewController.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/11/20.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "ViewController.h"
#import "MMPlaceHolder.h"
#import "FileModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController (){
    
    UIButton *_editButton;
    UIButton *_rencentlySelectButton;
    UIButton *_localSelectButton;
    
    NSMutableArray *grouparr0;
    NSMutableArray *grouparr1;
    NSMutableArray *grouparr2;
    NSMutableArray *grouparr3;
    NSMutableArray *grouparr4;
    
    NSMutableArray *grouparr5;
    
    NSMutableArray *recentlyButtonArray;
     NSMutableArray *localButtonArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"SelectCount"];
    grouparr0 = [NSMutableArray array];
    grouparr1 = [NSMutableArray array];
    grouparr2 = [NSMutableArray array];
    grouparr3 = [NSMutableArray array];
    grouparr4 = [NSMutableArray array];
    grouparr5 = [NSMutableArray array];
    
    //本地相册数据初始化
    _imageArrays = [NSMutableArray array];
    _imageTitleArray = [NSMutableArray array];
    _groupArrays = [NSMutableArray array];
    _videoArrays = [NSMutableArray array];
    _imageGroup = [NSMutableDictionary dictionary];
    [self.imageTitleArray addObject:@"相机胶卷"];
    //获取本地相册数据
     [self getLocalAblum];
    
    //最近文件5个按钮与本机文件5个按钮初始化数组
    recentlyButtonArray = [NSMutableArray array];
    localButtonArray = [NSMutableArray array];

    self.titleDataArray = [NSMutableArray array];
    self.dataDic = [NSMutableDictionary dictionary];
    self.selectArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _editButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_editButton addTarget:self action:@selector(eiditFile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_editButton];
    self.navigationItem.rightBarButtonItem = item;
    
    _isEditing = NO;
    _reloadFlag = YES;
   // WS(ws);
    [self _initData];  //初始化数据
    [self _initTableView]; //初始化列表
    [self _initSendView];  //初始化发送视图
    [self _initTitleView];  //初始化导航栏标题
    
    [self _initRecentlySegmentView]; //初始最近文件标题
    
    /*
     
     for (NSIndexPath *cellIndex in [ListTable indexPathsForSelectedRows])
     {
     UITableViewCell *otherCell = (UITableViewCell *)[ListTable cellForRowAtIndexPath:cellIndex];
     NSLog(@"这是第%d行",cellIndex.row);
     
     }
     
     */
    

}

- (void)_initData
{
    self.titleDataArray  = [NSMutableArray arrayWithObjects:@"昨天",@"一周内",@"一周前",@"一个月前",@"两个月前", nil];
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"file_icon_apk",@"file_icon_mp3",@"file_icon_doc",@"file_icon_html",@"file_icon_jpg",@"file_icon_pdf",@"file_icon_ppt",@"file_icon_video",@"file_icon_unknow",@"file_icon_xls",@"file_icon_orthers",@"file_icon_zip", nil];
    
    NSArray *imageArr1 = [NSArray arrayWithObjects:@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://www.qqcan.com/uploads/allimg/c120427/13354Y305A0-14922K.jpg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://www.qqcan.com/uploads/allimg/c120427/13354Y305A0-14922K.jpg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img1.3lian.com/gif/more/11/201212/45d7c18f191b2c97b2a75e060f6fd64d.jpg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg",@"http://img4.duitang.com/uploads/blog/201312/07/20131207194350_cQurE.thumb.600_0.jpeg", nil];
    
    for (int i = 0; i<=10; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeDoc;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize = 12345;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = imageArr1[i];
        [grouparr5 addObject:fileModel];
    }

    for (int i = 0; i<=10; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeDoc;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize = 12345;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = imageArr[i];
        [grouparr0 addObject:fileModel];
    }
    
    for (int i = 0; i<3; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeImage;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize = 433;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = [NSString stringWithFormat:@"%d",i+1];
        [grouparr1 addObject:fileModel];
    }
    
    for (int i = 0; i<3; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeVideo;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize =321;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = [NSString stringWithFormat:@"%d",i+1];
        [grouparr2 addObject:fileModel];
    }
    
    for (int i = 0; i<3; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeMusic;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize = 323;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = [NSString stringWithFormat:@"%d",i+1];
        [grouparr3 addObject:fileModel];
    }
    
    for (int i = 0; i<3; i++) {
        FileModel *fileModel = [[FileModel alloc]init];
        fileModel.fileType = FileTypeOthers;
        fileModel.fileName = [NSString stringWithFormat:@"文件-%d",i+1];
        fileModel.fileSize = 432;
        fileModel.fileTime = [NSDate date];
        fileModel.fileImageUrl = [NSString stringWithFormat:@"%d",i+1];
        [grouparr4 addObject:fileModel];
    }
    
    [self.dataDic setValue:grouparr0 forKey:@"0"];
    [self.dataDic setValue:grouparr1 forKey:@"1"];
    [self.dataDic setValue:grouparr2 forKey:@"2"];
    [self.dataDic setValue:grouparr3 forKey:@"3"];
    [self.dataDic setValue:grouparr4 forKey:@"4"];
    
}

//创建表视图
- (void)_initTableView{
    
    //最近 - 全部 文件
    _baseTableView = [[FileTableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
    _baseTableView.titleDataArray = self.titleDataArray;
    _baseTableView.dataDic = self.dataDic;
    _baseTableView.selectDelegate = self;
    _baseTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_baseTableView];
    
    
    //最近 - 图片 列表
    _baseCollectionView = [[ImageCollectionView alloc]initWithPicArray:self.dataDic title:self.titleDataArray frame:CGRectMake(0, 44+64, kScreenWidth, kScreenHeight-44-64)];
    _baseCollectionView.backgroundColor = [UIColor clearColor];
    _baseCollectionView.imageDelegate = self;
    [self.view addSubview:_baseCollectionView];
    _baseCollectionView.hidden = YES;
    
    //本机 - 图片 列表
    _photoCollectionView = [[ImageCollectionView alloc]initWithPicArray:self.imageGroup title:self.imageTitleArray frame:CGRectMake(0, 44+64, kScreenWidth, kScreenHeight-44-64)];
    _photoCollectionView.backgroundColor = [UIColor clearColor];
    _photoCollectionView.imageDelegate = self;
    [self.view addSubview:_photoCollectionView];
    _photoCollectionView.hidden = YES;


}


//初始化导航栏标题
- (void)_initTitleView{

    _segmentedControl = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(-1 ,0,118, 29.5) items:@[ @{@"text":@"最近"},@{@"text":@"本机"}] iconPosition:IconPositionRight  andSelectionBlock:^(NSUInteger segmentIndex) {
        if (segmentIndex == 0) {
            
            //选中最近文件，若为隐藏则显示，隐藏本机文件选择键
            if (_baseView.hidden) {
                _localBaseView.hidden = YES;
                [self getLastSelectButton:kRecentlyStyle];
                [self recentlyFile:_rencentlySelectButton];
                _baseView.hidden = NO;
            }
            
        }else if (segmentIndex == 1){
            //若本机文件选择键为空则初始化显示并隐藏最近文件选择键
            if (_localBaseView == nil) {
                _baseView.hidden = YES;
                [self _initLocalSegmentView];
                [self getLastSelectButton:kLocalStyle];
                [self localFile:_localSelectButton];
                
            }
            //选中本机文件，若为隐藏则显示，隐藏本机文件选择键
            if(_localBaseView.hidden){
                _baseView.hidden = YES;
                [self getLastSelectButton:kLocalStyle];
                [self localFile:_localSelectButton];
                _localBaseView.hidden = NO;
            }
        }}];
    
    UIColor *recentlyNormal = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Selected_ left_nor"]];
    UIColor *localNormal = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Select_ right_nor"]];
    UIColor *recentlySelect = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Selected_ left_pre"]];
    UIColor *localSelect = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Select_ right_pre"]];
    _segmentedControl.multipleTouchEnabled = YES;
    _segmentedControl.borderColor = [UIColor whiteColor];
    _segmentedControl.selectedColor = [NSMutableArray arrayWithArray:@[recentlySelect,localSelect]];
    _segmentedControl.color = [NSMutableArray arrayWithArray:@[recentlyNormal,localNormal]];
    _segmentedControl.textAttributes=@{NSFontAttributeName:[UIFont fontWithName:@"AppleGothic" size:15.0f], NSForegroundColorAttributeName:Color(40, 107, 199, 1)};
    _segmentedControl.selectedTextAttributes=@{NSFontAttributeName:[UIFont fontWithName:@"AppleGothic" size:15.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.titleView = _segmentedControl;


}

//初始化最近文件标题视图
- (void)_initRecentlySegmentView{
    WS(ws);
    _baseView = [UIView new];
    _baseView.backgroundColor = Color(244, 244, 244, 1);
    //[_baseView showPlaceHolder];
    [self.view addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64);
        make.left.equalTo(ws.view).with.offset(0);
        make.right.equalTo(ws.view).with.offset(0);
        make.width.mas_equalTo(ws.view.mas_width);
        make.height.mas_equalTo(@44);
    }];
    
    if (moveView != nil) {
        [moveView removeFromSuperview];
        moveView = nil;
        
    }
    moveView = [[UIImageView alloc]init];
    moveView.backgroundColor = [UIColor blueColor];
    moveView.frame = CGRectMake(0, 44, kScreenWidth/5, 2);
    [_baseView addSubview:moveView];
   

    UIButton *lastBtn = nil;
    
    NSArray *recentlyArray = @[@"全部",@"文档",@"图片",@"视频",@"音乐"];
    for (int i = 0; i <= 4; i++) {
        UIButton *button = [UIButton new];
        button.tag = 100*(i+1);
        [button setTitle:recentlyArray[i] forState:UIControlStateNormal];
        [button setTitle:recentlyArray[i]  forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(recentlyFile:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_baseView);
            make.height.mas_equalTo(_baseView);
            make.width.mas_equalTo(@(kScreenWidth/5));
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right);
            }else{
                make.left.equalTo(_baseView.mas_left);
            }
            
        }];
        lastBtn = button;
        [recentlyButtonArray addObject:button];
    }

}
//初始化本地文件标题视图
- (void)_initLocalSegmentView{
    WS(ws);
    _localBaseView = [UIView new];
    _localBaseView.backgroundColor = Color(244, 244, 244, 1);
    [self.view addSubview:_localBaseView];
    [_localBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64);
        make.left.equalTo(ws.view).with.offset(0);
        make.right.equalTo(ws.view).with.offset(0);
        make.width.mas_equalTo(ws.view.mas_width);
        make.height.mas_equalTo(@44);
    }];
    
    LocalMoveView = [[UIImageView alloc]init];
    LocalMoveView.backgroundColor = [UIColor blueColor];
    LocalMoveView.frame = CGRectMake(0, 44, kScreenWidth/5, 2);
    [_localBaseView addSubview:LocalMoveView];
    
    UIButton *lastBtn = nil;
    
    NSArray *localArray = @[@"文档",@"相机",@"视频",@"音乐",@"其他"];
    for (int i = 0; i <= 4; i++) {
        UIButton *button = [UIButton new];
        button.tag = 100*(i+1);
        [button setTitle:localArray[i] forState:UIControlStateNormal];
        [button setTitle:localArray[i]  forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(localFile:) forControlEvents:UIControlEventTouchUpInside];
        [_localBaseView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_localBaseView);
            make.height.mas_equalTo(_localBaseView);
            make.width.mas_equalTo(@(kScreenWidth/5));
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right);
            }else{
                make.left.equalTo(_localBaseView.mas_left);
            }
            
        }];
        lastBtn = button;
        [localButtonArray addObject:button];
    }
    
}

//初始化文件发送视图
- (void)_initSendView{
    _sendView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight, kScreenWidth, 44)];
    _sendView.backgroundColor = Color(214, 214, 214, 1);
    [self.view addSubview:_sendView];
    
    _sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 34)];
    _sizeLabel.backgroundColor = [UIColor clearColor];
    _sizeLabel.font = [UIFont systemFontOfSize:12];
    _sizeLabel.textColor = Color(108, 108, 108, 1);
    _sizeLabel.textAlignment = NSTextAlignmentCenter;
    
    [_sendView addSubview:_sizeLabel];
    

    _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_sendView.right - 80,7,70,30)];
    [_sendButton setBackgroundImage:[[UIImage imageNamed:@"but_send_nor"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
     [_sendButton setBackgroundImage:[[UIImage imageNamed:@"but_send_pre"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
    [_sendButton addTarget:self action:@selector(sendFile:) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.enabled = NO;
    [_sendView addSubview:_sendButton];

}

#pragma mark - Actions
//编辑文件
- (void)eiditFile
{
    //清空选中内容
    if (self.selectArr.count != 0) {
        [self.selectArr removeAllObjects];
    }
    //编辑状态
    if (_isEditing) {
        [_baseTableView setEditing:NO animated:YES];
        _baseCollectionView.allowMultiSelected = NO;
        _photoCollectionView.allowMultiSelected = NO;
        [_baseCollectionView resetSelectedItems];
        [_photoCollectionView resetSelectedItems];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"SelectCount"];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        _isEditing = NO;
        [_baseTableView reloadData];
        if (_sendButton.enabled) {
            _sendButton.enabled = NO;
            [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
            _sizeLabel.text = nil;
        }
        
        //隐藏发送视图
        [UIView animateWithDuration:0.2 animations:^{
            _sendView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 44);
            _baseTableView.height += 44;
        }];
    
    }else{
        [_baseTableView setEditing:YES animated:YES];
         _baseCollectionView.allowMultiSelected = YES;
        _photoCollectionView.allowMultiSelected = YES;
        [_editButton setTitle:@"取消" forState:UIControlStateNormal];
        _isEditing = YES;
        [_baseTableView reloadData];
        
        //显示发送视图
        [UIView animateWithDuration:0.2 animations:^{
            _sendView.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
            _baseTableView.height -= 44;
        }];
    }
}


//最近文件选择
- (void)recentlyFile :(UIButton *)button{
    
    [UIView animateWithDuration:0.2 animations:^{
        moveView.frame = CGRectMake(button.frame.origin.x, 44 , kScreenWidth/5, 2);
    }];
    
    switch (button.tag) {
        case 100:
            _baseTableView.hidden = NO;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = NO;
            _editButton.enabled = YES;
            break;
        case 200:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = YES;
           
            break;
        case 300:
            //最近图片文件
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = NO;
            _photoCollectionView.hidden = YES;
            self.showErrorText = NO;
            _editButton.enabled = YES;
            break;
        case 400:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            break;
        case 500:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            break;
        default:
            break;
    }

}

//本机文件选择
- (void)localFile :(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        LocalMoveView.frame = CGRectMake(button.frame.origin.x, 44 , kScreenWidth/5, 2);
    }];
    
    switch (button.tag) {
        case 100:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            
            break;
        case 200:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            if (_imageArrays.count && _photoCollectionView.dataDic.count == 0) {
                [self.imageGroup setValue:[[self.imageArrays reverseObjectEnumerator] allObjects] forKey:@"0"];
                _photoCollectionView.dataDic = self.imageGroup;
                [_photoCollectionView reloadData];
            }
            _photoCollectionView.hidden = NO;
            self.showErrorText = NO;
            _editButton.enabled = YES;
            break;
        case 300:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            break;
        case 400:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            break;
        case 500:
            _baseTableView.hidden = YES;
            _baseCollectionView.hidden = YES;
            _photoCollectionView.hidden = YES;
            self.showErrorText = YES;
            _editButton.enabled = NO;
            break;
        default:
            break;
    }

}

//发送文件
- (void)sendFile:(UIButton *)button{
   
}

//得到上一次的选中按钮
- (void)getLastSelectButton :(kFileStyle)fileStyle{
    if (fileStyle == kRecentlyStyle) {
        int i = (moveView.left * 5)/kScreenWidth;
        _rencentlySelectButton = recentlyButtonArray[i];
    }else if(fileStyle == kLocalStyle){
        int i = (LocalMoveView.left * 5)/kScreenWidth;
        _localSelectButton = localButtonArray[i];
    }
}

#pragma mark - DidSelectRow Delegate

//选择某项
- (void)didSelectedItem:(FileModel*)picModel withIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isEditing) {
        if (self.selectArr.count >= 5) {
          
        }
        [self.selectArr addObject:picModel];
        NSLog(@"%@",self.self.selectArr);
        _sendButton.enabled = YES;
        [_sendButton setTitle:[NSString stringWithFormat:@"发送(%lu)",(unsigned long)self.selectArr.count] forState:UIControlStateNormal];
        _fileSize += picModel.fileSize;
        _sizeLabel.text = [NSString stringWithFormat:@"已选 %f",_fileSize];
    }else{
        
    }
}
//取消选择某项
- (void)didDeSelectedItem:(FileModel *)picModel withIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing) {
        
        [self.selectArr removeObject:picModel];
        NSLog(@"%@",self.self.selectArr);
        if (self.selectArr.count == 0) {
            _sendButton.enabled = NO;
            [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
            _sizeLabel.text = nil;
        }else{
            _sendButton.enabled = YES;
            [_sendButton setTitle:[NSString stringWithFormat:@"发送(%lu)",(unsigned long)self.selectArr.count] forState:UIControlStateNormal];
            _fileSize -= picModel.fileSize;
            _sizeLabel.text = [NSString stringWithFormat:@"已选 %f",_fileSize];
    }
    }else{
        
    }

}

#pragma mark - getLocalAblum

//得到本地相册数据
- (void)getLocalAblum
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //遍历本地相册流
         ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (group != nil) {
                [self.groupArrays addObject:group]; //相册流，比如：相机胶卷，视频，QQ，美颜相机
            }else{
                //遍历每个相片组
                [self.groupArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    //每个相片组的照片
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        //缩略图不为空
                        if (result.thumbnail != nil) {
                            //结果为图片
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                                FileModel *fileModel = [[FileModel alloc]init];
                                fileModel.fileTime = [result valueForProperty:ALAssetPropertyDate];
                                fileModel.thumbnail = [UIImage imageWithCGImage:[result thumbnail]];
                                fileModel.fileName = [[result defaultRepresentation] filename];
                                fileModel.fileImageUrl = [[result defaultRepresentation] url];
                                fileModel.fileSize = [[result defaultRepresentation] size];
                                fileModel.fileType = FileTypeImage;
                                [_imageArrays addObject:fileModel];
                            }
                        }else if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]){
                            FileModel *fileModel = [[FileModel alloc]init];
                            fileModel.fileTime = [result valueForProperty:ALAssetPropertyDate];
                            fileModel.thumbnail = [UIImage imageWithCGImage:[result thumbnail]];
                            fileModel.fileName = [[result defaultRepresentation] filename];
                            fileModel.fileImageUrl = [[result defaultRepresentation] url];
                            fileModel.fileSize = [[result defaultRepresentation] size];
                            fileModel.fileType = FileTypeVideo;
                            [_videoArrays addObject:fileModel];
                        }
                    }];
                }];
            }
        };
       
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
        {
            NSString *errorMessage = nil;
            
            switch ([error code]) {
                case ALAssetsLibraryAccessUserDeniedError:
                case ALAssetsLibraryAccessGloballyDeniedError:
                    errorMessage = @"用户拒绝访问相册,请在<隐私>中开启";
                    break;
                default:
                    errorMessage = @"Reason unknown.";
                    break;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误,无法访问!"
                                          
                                                                   message:errorMessage
                                          
                                                                  delegate:self
                                          
                                                         cancelButtonTitle:@"确定"
                                          
                                                         otherButtonTitles:nil, nil];
                
                [alertView show];
            });
        };
        ALAssetsLibrary *assetsLib = [[ALAssetsLibrary alloc]init];
        [assetsLib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:listGroupBlock failureBlock:failureBlock];
    });
    
}

@end
