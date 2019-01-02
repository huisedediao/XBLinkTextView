//
//  XBLinkTextView.m
//  p70
//
//  Created by xxb on 2019/1/2.
//  Copyright © 2019年 chuango. All rights reserved.
//

#import "XBLinkTextView.h"
#import "NSMutableAttributedString+XBExtension.h"

@interface XBLinkTextView ()<UITextViewDelegate>
{
    UIColor *_linkColor;
    CGFloat _lineSpace;
}
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,copy) NSString *str;
@property (nonatomic,copy) XBLinkTextViewClickBlock clickBlock;
@property (nonatomic,copy) XBLinkTextViewNeedUpdateHeightBlock updateHeightBlock;
@property (nonatomic,strong) NSArray *linkStrRangeArr;
@end


@implementation XBLinkTextView

- (instancetype)initWithStr:(NSString *)str linkStrRangeArr:(NSArray *)linkStrRangeArr width:(CGFloat)width clickBlock:(XBLinkTextViewClickBlock)clickBlock updateHeightBlock:(XBLinkTextViewNeedUpdateHeightBlock)updateHeightBlock
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.width = width;
        self.str = str;
        self.clickBlock = clickBlock;
        self.updateHeightBlock = updateHeightBlock;
        self.linkStrRangeArr = linkStrRangeArr;
        self.delegate = self;
        self.editable = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setAttStr];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSInteger index = [[URL scheme] integerValue];
    if (self.clickBlock)
    {
        self.clickBlock(index, characterRange);
    }
    return YES;
}

- (void)setLinkColor:(UIColor *)linkColor
{
    _linkColor = linkColor;
    [self setAttStr];
}

- (UIColor *)linkColor
{
    if (_linkColor == nil)
    {
        return [UIColor blueColor];
    }
    return _linkColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    [self setAttStr];
}

- (CGFloat)lineSpace
{
    if (_lineSpace == 0)
    {
        return 5;
    }
    return _lineSpace;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setAttStr];
}

- (void)setAttStr
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.str];
    if (self.font)
    {
        [attStr xb_setFont:self.font range:xb_textRange];
    }
    if (self.textColor)
    {
        [attStr xb_setColor:self.textColor range:xb_textRange];
    }
    [attStr xb_setLineSpace:self.lineSpace range:xb_textRange];
    for (NSString *rangeStr in self.linkStrRangeArr)
    {
        NSInteger index = [self.linkStrRangeArr indexOfObject:rangeStr];
        NSString *linkUrl = [NSString stringWithFormat:@"%ld://xx",index];
        NSRange range = NSRangeFromString(rangeStr);
        [attStr xb_setLinkUrlStr:linkUrl linkStrcolor:self.linkColor range:range];
    }
    self.attributedText = attStr;
    
    CGFloat tempH = [self getHeight:self.width];
    if (tempH != self.height)
    {
        self.height = tempH;
        if (self.updateHeightBlock)
        {
            typeof(self) __weak weakSelf = self;
            self.updateHeightBlock(weakSelf,tempH);
            [self.superview layoutIfNeeded];
        }
    }
}

- (CGFloat)getHeight:(CGFloat)width
{
    CGSize size = [self.attributedText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return size.height + 18;
}
@end
