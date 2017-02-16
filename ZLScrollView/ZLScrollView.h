//
//  ZLScrollView.h
//  ZLScrollView
//
//  Created by libo on 2017/2/13.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapImageViewBlock)(NSInteger tag);


@interface ZLScrollView : UIView

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *currentPageColor;


@property (nonatomic, copy) TapImageViewBlock tapImageBlock;

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;

-(void) tapImageViewBlock:(TapImageViewBlock)tapImageBlock;

@end
