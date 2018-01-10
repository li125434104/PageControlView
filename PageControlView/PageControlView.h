//
//  PageControlView.h
//  PageControlView
//
//  Created by LXJ on 2018/1/10.
//  Copyright © 2018年 LianLuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlView : UIView


/**
 初始化PageControl

 @param count 个数
 */
- (void)setUI:(NSInteger)count;

/**
 PageControl的移动效果

 @param isRight 移动的方向
 */
- (void)animationWithIsRightDirection:(BOOL)isRight;
@end
