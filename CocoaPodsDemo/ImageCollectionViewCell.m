//
//  ImageCollectionViewCell.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFileModel:(FileModel *)fileModel{
    _fileModel = fileModel;
    
    //图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    imgView.tag = 99;
   // imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor clearColor];
//    [self loadImageWithPath:model.picPath toImageView:imgView];
    //[self loadImageWithPath:fileModel.fileImageUrl toImageView:imgView];
    if (fileModel.thumbnail) {
        
        imgView.image = fileModel.thumbnail;
    }else{
        imgView.image = [UIImage imageNamed:fileModel.fileImageUrl];
    }
    
   //[imgView setImage:[UIImage imageNamed:fileModel.fileImageUrl]];
    [self.contentView addSubview:imgView];
    
    //选中效果(遮罩层)
    overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    overlayView.image = [UIImage imageNamed:@"overlay_material"];
    overlayView.hidden = YES;
    overlayView.userInteractionEnabled = YES;
    [self.contentView addSubview:overlayView];

}

- (void)loadImageWithPath:(NSString*)path toImageView:(UIImageView*)imgView
{
    //异步加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            imgView.image = img;
            
        });
    });
}

- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if(selected)
    {
        if(self.showSelectedStyle)
            overlayView.hidden = NO;
    }
    else
    {
        if(self.showSelectedStyle)
            overlayView.hidden = YES;
    }
}


@end
