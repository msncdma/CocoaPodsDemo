//
//  ImageCollectionView.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "ImageCollectionView.h"

@implementation ImageCollectionView


- (id)initWithPicArray:(NSMutableDictionary *)dataDic title:(NSMutableArray *)titleDataArray frame:(CGRect)rect
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((kScreenWidth-20)/4, 70);
    //layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.minimumInteritemSpacing = 4;
    layout.minimumLineSpacing = 4;

    self = [super initWithFrame:rect collectionViewLayout:layout];
    if(self){
        [self _initView];
        self.dataDic = dataDic;
        self.titleDataArray = titleDataArray;
        
    }
    return self;
}

- (void)_initView{
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCell"];
    [self registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    self.selectArr = [NSMutableArray array];
    self.titleDataArray = [NSMutableArray array];
    self.backgroundColor = [UIColor clearColor];
    self.showsVerticalScrollIndicator = NO;
    selectCounts = 0;
}

- (void)setAllowMultiSelected:(BOOL)allowMultiSelected
{
    _allowMultiSelected = allowMultiSelected;
    
    self.allowsMultipleSelection = allowMultiSelected;
    self.showSelectedStyle = allowMultiSelected;
}

//选中某项
- (void)selectItem:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if([self collectionView:self shouldSelectItemAtIndexPath:indexPath])
    {
        [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self collectionView:self didSelectItemAtIndexPath:indexPath];
    }

}
//重置选中项
- (void)resetSelectedItems
{
    NSArray *indexPaths = [self indexPathsForSelectedItems];
    if(!indexPaths || indexPaths.count < 1) return;
    
    for(NSIndexPath *index in indexPaths)
    {
        [self deselectItemAtIndexPath:index animated:YES];
    }
    [self reloadData];

}
#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titleDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([self.selectArr containsObject:string]) {
        
        NSArray *array  = (NSArray *)[self.dataDic objectForKey:string];
        return array.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    FileModel *model = [[FileModel alloc]init];
    model = (FileModel *)self.dataDic[sectionStr][indexPath.row];
    static NSString *identifier = @"ImageCell";
    ImageCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell.contentView.subviews.count > 0)
    {
        for(UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }

    cell.fileModel = model;
    
    if(self.allowsMultipleSelection){
        for(NSIndexPath *index in collectionView.indexPathsForSelectedItems)
        {
            if(index.section == indexPath.section && index.row == indexPath.row)
            {
                cell.showSelectedStyle = YES;
                cell.selected = YES;
            }
        }
    }

    return cell;

}

//头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqual:UICollectionElementKindSectionHeader])
    {
         CollectionReusableView *headView  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headView.arrowView.tag = 20000 + indexPath.section;
        
        NSString *string = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        
        if ([_selectArr containsObject:string]) {
             headView.arrowView.image = [UIImage imageNamed:@"buddy_header_arrow_down"];
        }
        else
        {
             headView.arrowView.image = [UIImage imageNamed:@"buddy_header_arrow_right"];
        }
        headView.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        headView.titleLabel.text = self.titleDataArray[indexPath.section];
        
        headView.button.tag = 100+indexPath.section;
        [headView.button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
         return headView;

    }
    return nil;
}

//头部视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kScreenWidth,40};
    return size;
}
//脚部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size={kScreenWidth,0};
    return size;
}

#pragma mark - UICollectionView Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.allowMultiSelected){
        return NO;
    }
    
    NSString *selectCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"SelectCount"];
    if (selectCount && [selectCount intValue] != 0) {
        if ([selectCount integerValue] >= 5) {
            ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
            cell.showSelectedStyle = !self.showSelectedStyle;
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能选中5个" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return NO;
        }
    }
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.showSelectedStyle = self.showSelectedStyle;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[selectCount intValue]+1 ] forKey:@"SelectCount"];
    return YES;
}

//选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if([self.imageDelegate respondsToSelector:@selector(didSelectedItem:withIndexPath:)]){
        [self.imageDelegate didSelectedItem:cell.fileModel withIndexPath:indexPath];
    }
        
}

//取消选中
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if([self.imageDelegate respondsToSelector:@selector(didDeSelectedItem:withIndexPath:)]){
        [self.imageDelegate didDeSelectedItem:cell.fileModel withIndexPath:indexPath];
    }

     NSString *selectCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"SelectCount"];
     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[selectCount intValue]-1 ] forKey:@"SelectCount"];
}
#pragma mark - Actions

- (void)doButton :(UIButton *)button
{
    NSString *string = [NSString stringWithFormat:@"%d",button.tag-100];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([_selectArr containsObject:string])
    {
        [_selectArr removeObject:string];
    }
    else
    {
        [_selectArr addObject:string];
    }
    
    //记录选中的文件
   NSArray *indexPaths =[self indexPathsForSelectedItems];
    //刷新
    [self reloadData];
    //当展开时候重新选中
   for (NSIndexPath *indexPath in indexPaths) {
       NSLog(@"%d%d",indexPath.section,indexPath.row);
        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }

}

@end
