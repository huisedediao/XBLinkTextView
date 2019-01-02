//
//  ViewController.m
//  XBLinkTextView
//
//  Created by xxb on 2019/1/2.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "XBLinkTextView.h"

@interface ViewController ()
@property (nonatomic,strong) XBLinkTextView *linkTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = 200;
    
    NSString *str1 = @"1111111111100000000000000000000000000000000000000";
    NSString *str2 = @"2222";
    NSString *str3 = @"3333333333";
    NSString *all = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    NSString *range2_str = NSStringFromRange([all rangeOfString:str1]);
    NSArray *rangeArr = @[range2_str];
    typeof(self) __weak weakSelf = self;
    self.linkTextView = [[XBLinkTextView alloc] initWithStr:all linkStrRangeArr:rangeArr width:width clickBlock:^(NSInteger index, NSRange range) {
        NSLog(@"click:%zd",index);
    } updateHeightBlock:^(XBLinkTextView * _Nonnull textView, CGFloat height) {
        weakSelf.linkTextView.frame = CGRectMake(0, 100, width, height);
    }];
    [self.view addSubview:self.linkTextView];
    weakSelf.linkTextView.frame = CGRectMake(0, 100, width, 100);
    self.linkTextView.backgroundColor = [UIColor orangeColor];
}


@end
