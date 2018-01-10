//
//  ViewController.m
//  PageControlView
//
//  Created by LXJ on 2018/1/10.
//  Copyright © 2018年 LianLuo. All rights reserved.
//

#import "ViewController.h"
#import "PageControlView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PageControlView *pageControl = [[PageControlView alloc] initWithFrame:CGRectMake(50, 200, 300, 20)];
    [self.view addSubview:pageControl];
    [pageControl setUI:5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
