//
//  FileCell.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/4.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "FileCell.h"
#import "Masonry.h"

@implementation FileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
     frame.size.height = _cellHeight;
    [super setFrame:frame];
}

- (void)_initView{
    //文件图片
    self.filePhoto = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.filePhoto.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.filePhoto];
    
    //文件名
    self.fileNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.fileNameLabel.backgroundColor = [UIColor clearColor];
    self.fileNameLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:self.fileNameLabel];
    
    
    //文件时间
    self.filetimeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.filetimeLabel.backgroundColor  = [UIColor clearColor];
    self.filetimeLabel.textColor = [UIColor lightGrayColor];
    self.filetimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.filetimeLabel];
    
    //文件大小
    
    self.fileSize = [[UILabel alloc]initWithFrame:CGRectZero];
     self.fileSize.backgroundColor  = [UIColor clearColor];
     self.fileSize.textColor = [UIColor lightGrayColor];
     self.fileSize.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview: self.fileSize];
    
    
    //分割线
    self.imageLine = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.imageLine];
}


- (void)layoutSubviews{
    [super layoutSubviews];
  
    self.filePhoto.frame = CGRectMake(10, 10, 50, 50);
    self.filePhoto.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fileModel.fileImageUrl]];
    
    self.fileNameLabel.frame = CGRectMake(self.filePhoto.right+5, 5, self.contentView.width - 10 - self.filePhoto.left, 20);
    self.fileNameLabel.text = self.fileModel.fileName;
    
    self.fileSize.frame = CGRectMake(self.filePhoto.right+5, self.fileNameLabel.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    self.fileSize.text = [NSString stringWithFormat:@"%f",self.fileModel.fileSize];
    
    self.filetimeLabel.frame = CGRectMake(self.filePhoto.right+10, self.fileSize.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    
    self.filetimeLabel.text = [self stringFromDate:self.fileModel.fileTime];
    
    self.imageLine.frame = CGRectMake(0, self.filetimeLabel.bottom+2, self.contentView.width, 1);
    
    _cellHeight = self.imageLine.bottom;
   
}

- (void)setFrame1{
    self.filePhoto.frame = CGRectMake(10, 10, 50, 50);
    self.filePhoto.image = [UIImage imageNamed:self.fileModel.fileImageUrl];
    
    self.fileNameLabel.frame = CGRectMake(self.filePhoto.right+5, 5, self.contentView.width - 10 - self.filePhoto.left, 20);
    self.fileNameLabel.text = self.fileModel.fileName;
    
    self.fileSize.frame = CGRectMake(self.filePhoto.right+5, self.fileNameLabel.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    self.fileSize.text = [NSString stringWithFormat:@"%f",self.fileModel.fileSize];
    
    self.filetimeLabel.frame = CGRectMake(self.filePhoto.right+10, self.fileSize.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    
    self.filetimeLabel.text = [self stringFromDate:self.fileModel.fileTime];
    
    self.imageLine.frame = CGRectMake(0, self.filetimeLabel.bottom+2, self.contentView.width, 1);
    
    _cellHeight = self.imageLine.bottom;
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}



/*

- (void)setFileModel:(FileModel *)fileModel{
    self.fileModel = fileModel;
    self.filePhoto.frame = CGRectMake(10, 10, 50, 50);
    self.filePhoto.image = [UIImage imageNamed:self.fileModel.fileImageUrl];
    
    self.fileNameLabel.frame = CGRectMake(self.filePhoto.right+5, 5, self.contentView.width - 10 - self.filePhoto.left, 20);
     self.fileNameLabel.text = self.fileModel.fileName;
    
    self.fileSize.frame = CGRectMake(self.filePhoto.right+5, self.fileNameLabel.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    self.fileSize.text = self.fileModel.fileSize;
    
    self.filetimeLabel.frame = CGRectMake(self.filePhoto.right+10, self.fileSize.bottom + 2, self.contentView.width  - 10 - self.filePhoto.left, 20);
    self.filetimeLabel.text = self.fileModel.fileTime;
    
    self.imageLine.frame = CGRectMake(0, self.filetimeLabel.bottom+2, self.contentView.width, 1);
 
    /*
    [self.filePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
    }];
    self.filePhoto.image = [UIImage imageNamed:self.fileModel.fileImageUrl];
    
    [self.fileNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.filePhoto.mas_right).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(10);
        make.height.mas_equalTo(@25);
    }];
    self.fileNameLabel.text = self.fileModel.fileName;
    
    
    [self.filetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.filePhoto.mas_right).with.offset(10);
        make.top.equalTo(self.fileNameLabel).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(10);
        make.height.mas_equalTo(@20);
    }];
    self.filetimeLabel.text = self.fileModel.fileTime;

    
    [self.fileSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.filePhoto.mas_right).with.offset(10);
        make.top.equalTo(self.filetimeLabel).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(10);
        make.height.mas_equalTo(@20);
    }];
    self.fileSize.text = self.fileModel.fileSize;
    
    [self.imageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.and.bottom.equalTo(self.contentView);
        make.top.equalTo(self.filetimeLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(@1);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.imageLine.mas_bottom);
    }];
 
 
}

*/

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        
    }else{
        
    }
}

@end
