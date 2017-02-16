//
//  ZLScrollView.m
//  ZLScrollView
//
//  Created by libo on 2017/2/13.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "ZLScrollView.h"

#define ScrollView self.scrollView.bounds.size.width

@interface ZLScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger ImageCount;


@end

@implementation ZLScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray {

    if (self = [super initWithFrame:frame]) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((frame.size.width-100)/2, frame.size.height - 20, 100, 20)];
        [self addSubview:self.pageControl];
        self.pageControl.hidesForSinglePage = YES;
        self.ImageCount = imageArray.count;
        self.pageControl.transform = CGAffineTransformMakeScale(0.9, 0.9);
        if (_ImageCount < 1) {
            self.pageControl.numberOfPages = 1;
        }else {
            self.pageControl.numberOfPages = _ImageCount;
        }
        
        CGFloat imageViewW = frame.size.width;
        CGFloat imageViewH = frame.size.height;
        CGFloat imageViewY = 0;
        
        for (NSInteger i = 0; i < _ImageCount; i++) {
            self.imageView = [[UIImageView alloc]init];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewAction:)];
            self.imageView.userInteractionEnabled = YES;
            self.imageView.tag = i + 1;
            [self.imageView addGestureRecognizer:tapGesture];
            CGFloat imageViewX = imageViewW * i;
            self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            //给imageView赋值
            self.imageView.image = [UIImage imageNamed:imageArray[i]];
            [self.scrollView addSubview:self.imageView];
        }
        
        self.scrollView.contentSize = CGSizeMake(imageViewW * _ImageCount, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.pageControl.numberOfPages = _ImageCount;
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor purpleColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;

        [self timer];
    }
    return self;
}


- (void)tapImageViewAction:(UITapGestureRecognizer *)tap {
    
    __weak typeof(self)weakSelf = self;
    if (weakSelf.tapImageBlock) {
        weakSelf.tapImageBlock(tap.view.tag);
    }
}

- (void)tapImageViewBlock:(TapImageViewBlock)tapImageBlock {

    self.tapImageBlock = tapImageBlock;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)nextPage {
    
    if (_ImageCount > 0) {
        int page = (self.pageControl.currentPage + 1) % (int)_ImageCount;
        self.pageControl.currentPage = page;
        [self pageChanged:self.pageControl];
    }
}

- (void)pageChanged:(UIPageControl *)pageControl {
    
    //根据页数,获得对应位置图片的x坐标
    CGFloat x = (pageControl.currentPage) * self.scrollView.bounds.size.width;
    //根据坐标值,调整scrollView的视图内容
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger page = (_scrollView.contentOffset.x + ScrollView/2) /ScrollView;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self timer];
//    [self.timer fire];
}

@end
