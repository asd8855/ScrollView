//
//  ViewController.m
//  ZLScrollView
//
//  Created by libo on 2017/2/13.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "ViewController.h"
#import "ZLScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = @[
                       @"img_01",
                       @"img_02",
                       @"img_03",
                       @"img_04",
                       @"img_05"
                       ];
    ZLScrollView *scrollView = [[ZLScrollView alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 200) ImageArray:array];
    scrollView.tintColor = [UIColor purpleColor];
    scrollView.currentPageColor = [UIColor orangeColor];
    [scrollView tapImageViewBlock:^(NSInteger tag) {
        
        NSLog(@"点击图片Block回调  %@",array[tag]);
    }];
    
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
