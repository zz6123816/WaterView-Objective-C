//
//  WaterView.h
//  GiftBox
//
//  Created by 康健 on 15/11/23.
//  Copyright © 2015年 xinyihezi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView
/** 当前的百分比 用来设置水量 */
@property (nonatomic, assign) CGFloat percent;
/** 水的颜色 */
@property (nonatomic, strong) UIColor * waterColor;
@end
