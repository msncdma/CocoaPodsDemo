//
//  FileTableView.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/4.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FileTableView : UITableView<UITableViewDelegate,UITableViewDataSource>{
    int selectCounts;
}

@property(nonatomic, assign)id <DidSelectRow> selectDelegate;

@property (nonatomic ,strong)NSMutableDictionary *dataDic;  //存每个分组的数据
@property (nonatomic ,strong)NSMutableArray *titleDataArray;//存每个分组的标题
@property (nonatomic ,strong)NSMutableArray *selectArr;//判断是否显示二级菜单

@end
