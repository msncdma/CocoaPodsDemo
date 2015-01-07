//
//  ImageCollectionView.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"
#import "ImageCollectionViewCell.h"
#import "CollectionReusableView.h"

@interface ImageCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>{
    int selectCounts;
}
    
- (id)initWithPicArray:(NSMutableDictionary *)dataDic title:(NSMutableArray *)titleDataArray frame:(CGRect)rect;

//是否允许多选
@property (nonatomic) BOOL allowMultiSelected;
//剩余选择数
@property (nonatomic) NSInteger remainCount;

@property (nonatomic ,strong)NSMutableDictionary *dataDic;  //存每个分组的数据
@property (nonatomic ,strong)NSMutableArray *titleDataArray;//存每个分组的标题
@property (nonatomic ,strong)NSMutableArray *selectArr;//判断是否显示二级菜单

//是否显示选中效果
@property (nonatomic) BOOL showSelectedStyle;

//选中某项
- (void)selectItem:(NSInteger)index;
//重置选中项
- (void)resetSelectedItems;

@property(nonatomic,assign)id <DidSelectRow> imageDelegate;

@end
