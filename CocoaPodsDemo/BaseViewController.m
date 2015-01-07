//
//  BaseViewController.m
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && self.isBackButton) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(0, 0, 41, 44);
        if(IS_IOS7) button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        button.showsTouchWhenHighlighted = YES;
        [button setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nav_back_selected.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem ;
    }
    
}

//复写title
- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.textColor = Color(235, 255, 254, 1);
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
#pragma mark - 显示信息

- (void)setErrorTextToView:(BOOL)showErrorText
{
    if(errorTextLabel != nil && errorTextLabel.superview != nil)
        [errorTextLabel removeFromSuperview],errorTextLabel = nil;
    if(refreshTextLabel != nil && refreshTextLabel.superview != nil)
        [refreshTextLabel removeFromSuperview],refreshTextLabel = nil;
    if(failedImageView != nil && failedImageView.superview != nil)
        [failedImageView removeFromSuperview],failedImageView = nil;
    
    if(showErrorText)
    {
       
        
        failedImageView = [[UIImageView alloc]initWithFrame:CGRectMake((int)((self.view.frame.size.width - 113)/2), (int)((self.view.frame.size.height-44 - 98)/2), 113, 98)];
        failedImageView.backgroundColor = [UIColor clearColor];
        failedImageView.image = [UIImage imageNamed:@"no_file"];
        [self.view addSubview:failedImageView];
        
        
        NSString *errorText = @"该分类没有文件";
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        CGSize size = [errorText sizeWithFont:font];
        errorTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((int)((self.view.frame.size.width - size.width)/2), failedImageView.bottom +2, size.width, size.height)];
        errorTextLabel.backgroundColor = [UIColor clearColor];
        errorTextLabel.font = font;
        [errorTextLabel setTextColor:Color(174, 174, 174, 1)];
        errorTextLabel.text = errorText;
        [self.view addSubview:errorTextLabel];
        
    }
}


- (void)showMessageOnViewCenter:(NSString *)message
{
    self.showErrorText = NO;
    
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGSize size = [message sizeWithFont:font constrainedToSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    errorTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((int)((self.view.frame.size.width - size.width)/2), (int)((self.view.frame.size.height - size.height)/2 - 44), size.width, size.height)];
    errorTextLabel.backgroundColor = [UIColor clearColor];
    errorTextLabel.font = font;
    errorTextLabel.text = message;
    errorTextLabel.numberOfLines = 0;
    [self.view addSubview:errorTextLabel];
}

#pragma mark - 恢复网络

- (void)recover{
    //子类重写时指定网络恢复后执行的操作动作
}


- (void)setBackButton:(BOOL)backButtonEnabled
{
    if(backButtonEnabled)
    {
        UIEdgeInsets capInsets = UIEdgeInsetsMake(0, 18, 0, 8);
        UIButton *button = [self buttonWithImage:[UIImage imageNamed:@"返回normal.png"] highlightImage:[UIImage imageNamed:@"返回pressed.png"] capInsets:capInsets];
        //[self setButtonText:@"返回" onButton:button];
        [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backButton;
    }
}


- (void)setNavigationBarBackgroundImage:(UIImage*)backgroundImage
{
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

//根据背景图片、高亮背景图片和图片拉伸端盖生成UIButton
- (UIButton*)buttonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage capInsets:(UIEdgeInsets)capInsets
{
    UIImage *buttonImage = [image resizableImageWithCapInsets:capInsets];
    UIImage *buttonHighlightImage = [highlightImage resizableImageWithCapInsets:capInsets];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    button.titleEdgeInsets = capInsets;
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonHighlightImage forState:UIControlStateHighlighted];
    
    return button;
}

#pragma mark - 返回上一页

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)cancelAction{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
