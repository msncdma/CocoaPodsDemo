//
//  BaseViewController.h
//  CocoaPodsDemo
//
//  Created by song.he on 14/12/18.
//  Copyright (c) 2014年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController{
    UIView *_loadingView;   //显示加正在加载视图
    
    //点击手势
    UITapGestureRecognizer *tapGesture;
    //错误标语
    UILabel *errorTextLabel;
    //刷新标语
    UILabel *refreshTextLabel;
    //失败的图片
    UIImageView *failedImageView;
    //请求标识，代表每次请求的数据类型（比如文字作品、图片作品等）
    int _requestFlag;

}

@property (nonatomic, assign)BOOL isBackButton;
//设置带菜单的顶部栏
@property (nonatomic,setter = setMenuBar:) BOOL menuBarEnabled;
//设置返回按钮
@property (nonatomic,setter = setBackButton:) BOOL backButtonEnabled;
//是否开启键盘辅助工具栏
@property (nonatomic) BOOL keyBoardViewEnabled;


//设置导航栏的背景图
- (void)setNavigationBarBackgroundImage:(UIImage*)backgroundImage;

//根据背景图片、高亮背景图片和图片拉伸端盖生成UIButton
- (UIButton*)buttonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage capInsets:(UIEdgeInsets)capInsets;

//返回上一页，子类可重写此方法自定义返回逻辑
- (void)goBack;

//在屏幕中央显示错误标语：“加载内容失败，请检查您的网络”[注：只可在主线程中调用]
@property (nonatomic,assign,setter = setErrorTextToView:) BOOL showErrorText;

- (void)setErrorTextToView:(BOOL)showErrorText;
- (void)showMessageOnViewCenter:(NSString *)message;
- (void)recover;

@end
