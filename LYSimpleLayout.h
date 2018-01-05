//
//  LYSimpleLayout.h
//  LYSimpleLayout
//
//  Created by Lynn on 2018/1/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface LYSimpleLayoutAttribute : NSObject

/*
 官方约束计算方法。
 Create constraints explicitly.  Constraints are of the form "view1.attr1 = view2.attr2 * multiplier + constant"
 If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
 LYSimpleLayout 是对官方API的一层封装，目的是使用起来更加便捷易懂
 接下来是对 约束的计算方法封装的介绍（view1.attr1 = view2.attr2 * multiplier + constant）
 
 | view1      |   要建立约束的视图
 | attr1      |   要针对哪个属性建立约束
 | view2      |   约束添加到哪个视图上
 | attr2      |   view1的属性attr1相对view2的哪个属性建立约束
 | multiplier |   相对attr2放缩几倍
 | constant   |   相对attr2偏移固定值
 */

/**********************************************************************
 下面这些属性是设置 view2
 **********************************************************************/
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *(^lessThanOrEqualTo)(id view);
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *(^equalTo)(id view);
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *(^greaterThanOrEqualTo)(id view);

/**********************************************************************
 下面这些属性是设置 view2 的 attr
 **********************************************************************/
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToLeft;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToRight;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToTop;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToBottom;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToLeading;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToTrailing;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToWidth;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToHeight;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToCenterX;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToCenterY;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToLastBaseline;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToBaseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToFirstBaseline;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToLeftMargin;
#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToRightMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToTopMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToBottomMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToLeadingMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToTrailingMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToCenterXWithinMargins;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_relateToCenterYWithinMargins;
#endif

/**********************************************************************
 下面这些属性分别是设置 multiplier 和 constant
 **********************************************************************/
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *(^multipliedBy)(CGFloat multipier);
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *(^offset)(CGFloat offset);

/**********************************************************************
 建立约束的方法
 **********************************************************************/
@property (nonatomic, strong, readonly) NSLayoutConstraint *(^install)(void);

- (instancetype)initWithView:(UIView *)view attribute:(NSLayoutAttribute)attribute;

@end

@interface UIView (LYSimpleLayout)

/**********************************************************************
 通过UIView的类别，建立要创建约束对象view的LYSimpleLayoutAttribute，并设置它要建立约束的属性
 **********************************************************************/
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_left;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_right;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_top;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_bottom;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_leading;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_trailing;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_width;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_height;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_centerX;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_centerY;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_lastBaseline;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_firstBaseline;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_leftMargin;
#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_rightMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_topMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_bottomMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_leadingMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_trailingMargin;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_centerXWithinMargins;
@property (nonatomic, strong, readonly) LYSimpleLayoutAttribute *ly_centerYWithinMargins;
#endif

@end

@interface NSArray (LYSimpleLayout)
/**********************************************************************
 建立约束的方法
 **********************************************************************/
@property (nonatomic, strong, readonly) NSArray <NSLayoutConstraint *> *(^install)(void);
@end
