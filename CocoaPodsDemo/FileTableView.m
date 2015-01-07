//
//  FileTableView.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/4.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "FileTableView.h"
#import "FileModel.h"
#import "FileCell.h"


@interface FileTableView()

@end

@implementation FileTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];

    }
    return self;
}

- (void)_initView{

    self.delegate = self;
    self.dataSource = self;
    
    self.selectArr = [NSMutableArray array];
    self.backgroundColor = Color(220, 223, 223, 1);
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    selectCounts = 0;
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return self.titleDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([self.selectArr containsObject:string]) {
        
        NSArray *array  = (NSArray *)[self.dataDic objectForKey:string];
        return array.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    FileModel *model = [[FileModel alloc]init];
    model = (FileModel *)self.dataDic[sectionStr][indexPath.row];
   // if ([model.cellName isEqualToString:@"FileCell"]) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        FileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[FileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    cell.fileModel = model;
    cell.imageLine.image = [UIImage imageNamed:@"line"];
    [cell setFrame1];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    imageView.tag = 20000+section;
    
    //判断该section是不是被选中
    
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    
    if ([_selectArr containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right"];
    }

    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.left + 20, 0, kScreenWidth - 20, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = self.titleDataArray[section];
    [view addSubview:titleLabel];
    
    
    [view addSubview:imageView];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth, 40);
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    lineImage.clipsToBounds = NO;
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:lineImage];


    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 39;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


-(void)doButton:(UIButton *)button{
    
    NSString *string = [NSString stringWithFormat:@"%ld",button.tag-100];
    
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
    NSArray *indexPaths =[self indexPathsForSelectedRows];
    //刷新
    [self reloadData];
    //当展开时候重新选中
    for (NSIndexPath *indexPath in indexPaths) {
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 72;
}

//编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.editing) {

        NSString *selectCount =  [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectCount"];
        if (selectCount && [selectCount intValue] != 0) {
            if ([selectCount intValue] >= 5 ) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能选中5个" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                return nil;
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[selectCount intValue] +1] forKey:@"SelectCount"];
        return indexPath;
    }else{
        return indexPath;
    }
}
//选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileCell *cell = (FileCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if([self.selectDelegate respondsToSelector:@selector(didSelectedItem:withIndexPath:)]){
        [self.selectDelegate didSelectedItem:cell.fileModel withIndexPath:indexPath];
    }
    

}


//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FileCell *cell = (FileCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if([self.selectDelegate respondsToSelector:@selector(didDeSelectedItem:withIndexPath:)]){
        [self.selectDelegate didDeSelectedItem:cell.fileModel withIndexPath:indexPath];
    }
    
    //保存选中的个数
    NSString *selectCount =  [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectCount"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[selectCount intValue] -1 ] forKey:@"SelectCount"];

}

@end
