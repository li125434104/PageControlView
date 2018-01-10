

//
//  PageControlView.m
//  PageControlView
//
//  Created by LXJ on 2018/1/10.
//  Copyright © 2018年 LianLuo. All rights reserved.
//

#import "PageControlView.h"
#import "UIView+Extensions.h"

//pageControl宽高
static NSInteger const normalBtnWH = 8.0;
//pageControl选中宽
static NSInteger const selectBtnWidth = 28.0;
//间距
static NSInteger const btnMargin = 20.0;

static NSInteger const delayTime = 3;


@interface PageControlView ()

@property (nonatomic, strong) NSMutableArray *btnArray;   //按钮的Array,设置成button是防止有点击的操作
@property (nonatomic, strong) NSMutableArray *btnXArray;  //按钮的X位置
@property (nonatomic, strong) UIButton *currentBtn;       //当前选中的按钮

@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PageControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.selectColor = [UIColor blueColor];
        self.normalColor = [UIColor lightGrayColor];
    }
    return self;
}

//初始化pageControl，主要是在X的位置
- (void)setUI:(NSInteger)count {
    for (UIButton *btn in self.subviews) {
        [btn removeFromSuperview];
    }
    
    if (count == 0) {
        return;
    }
    
    CGFloat X = self.frame.origin.x;
    CGFloat Y = (self.frame.size.height - normalBtnWH) / 2;
    
    [self.btnArray removeAllObjects];
    [self.btnXArray removeAllObjects];
    
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(X, Y, normalBtnWH, normalBtnWH);
        button.layer.cornerRadius = normalBtnWH / 2;
        button.backgroundColor = self.normalColor;
        button.alpha = 1;
        button.tag = 1000 + i;
        [self.btnXArray addObject:[NSString stringWithFormat:@"%f", button.frame.origin.x]];
        [self.btnArray addObject:button];
        [self addSubview:button];
        
        if (0 == i) {
            button.frame = CGRectMake(X, Y, count == 0 ? normalBtnWH : selectBtnWidth, normalBtnWH);
            button.backgroundColor = self.selectColor;
            self.currentBtn = button;
            X += btnMargin + selectBtnWidth;
        } else {
            X += btnMargin + normalBtnWH;
        }
    }
    
    [self addTimer];

}

- (void)addTimer {
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(scrollAnimation:) userInfo:nil repeats:YES];
}

- (void)scrollAnimation:(NSTimer *)timer {
    //画面从左往右移动，后一页
    [self animationWithIsRightDirection:NO];
}

- (void)animationWithIsRightDirection:(BOOL)isRight {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //改变颜色
        UIButton *nextButton = [self getNextButtonWithDirection:isRight];
        nextButton.backgroundColor = self.selectColor;
        self.currentBtn.backgroundColor = self.normalColor;
        
        //改变frame
        self.currentBtn.width = normalBtnWH;
        nextButton.width = selectBtnWidth;
        
        //改变button的X的位置
        if (isRight) {
            if (self.currentBtn.tag == (1000 + self.btnArray.count - 1)) {
                for (UIButton *tempBtn in self.btnArray) {
                    tempBtn.left += (selectBtnWidth - normalBtnWH);
                }
            }
            nextButton.left -= (selectBtnWidth - normalBtnWH);
        } else {
            if (self.currentBtn.tag == 1000) {
                for (UIButton *tempBtn in self.btnArray) {
                    tempBtn.left -= (selectBtnWidth - normalBtnWH);
                }
            }
            self.currentBtn.left += (selectBtnWidth - normalBtnWH);
        }

        self.currentBtn = [self getNextButtonWithDirection:isRight];

    }];
}

//获取移动的下一个button
- (UIButton *)getNextButtonWithDirection:(BOOL)isRight {
    if (isRight) {
        //右移
        if (self.currentBtn.tag == (1000 + self.btnArray.count - 1)) {
            //如果是最后一个button是currentButton，则移到首个
            return self.btnArray.firstObject;
        } else {
            return [self viewWithTag:self.currentBtn.tag + 1];
        }
    } else {
        //左移
        if (self.currentBtn.tag == 1000) {
            //如果左移到第一个button了，则下一个button是最后一个
            return self.btnArray.lastObject;
        } else {
            return [self viewWithTag:self.currentBtn.tag - 1];
        }
    }
}

#pragma mark - Setter & Getter

- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)btnXArray {
    if (_btnXArray == nil) {
        _btnXArray = [NSMutableArray array];
    }
    return _btnXArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
