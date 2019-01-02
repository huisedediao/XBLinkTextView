//
//  XBLinkTextView.h
//  p70
//
//  Created by xxb on 2019/1/2.
//  Copyright © 2019年 chuango. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XBLinkTextView;

typedef void (^XBLinkTextViewClickBlock)(NSInteger index,NSRange range);
typedef void (^XBLinkTextViewNeedUpdateHeightBlock)(XBLinkTextView *textView,CGFloat height);

@interface XBLinkTextView : UITextView

/**
 设置frame或者约束的时候，不用设置高度，在updateHeightBlock里设置高度
 str : 所有要展示的文字
 linkStrRangeArr : 超链接的range，传range转换后的string
 clickBlock : 点击超链接的回调
 width : 控件的宽
 updateHeightBlock : 更新控件height的回调
 */
- (instancetype)initWithStr:(NSString *)str linkStrRangeArr:(NSArray *)linkStrRangeArr width:(CGFloat)width clickBlock:(XBLinkTextViewClickBlock)clickBlock updateHeightBlock:(XBLinkTextViewNeedUpdateHeightBlock)updateHeightBlock;

/**
 链接部分的颜色，默认蓝色
 */
@property (nonatomic,strong) UIColor *linkColor;
/**
 行间距,默认5
 */
@property (nonatomic,assign) CGFloat lineSpace;
@end

NS_ASSUME_NONNULL_END
