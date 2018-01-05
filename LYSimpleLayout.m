//
//  LYSimpleLayout.m
//  LYSimpleLayout
//
//  Created by Lynn on 2018/1/1.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LYSimpleLayout.h"

@interface LYSimpleLayoutAttribute()

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, assign) NSLayoutAttribute attribute;
@property (nonatomic, assign) NSLayoutRelation relation;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, assign) NSLayoutAttribute attribute2;
@property (nonatomic, assign) CGFloat multiplier;
@property (nonatomic, assign) CGFloat constant;
@end

@implementation LYSimpleLayoutAttribute

- (instancetype)initWithView:(UIView *)view attribute:(NSLayoutAttribute)attribute
{
    if (self = [super init]) {
        self.view1      = view;
        self.attribute  = attribute;
        self.view2      = nil;
        self.attribute2 = NSLayoutAttributeNotAnAttribute;
        self.multiplier = 1.0;
        self.constant   = 0;
    }
    return self;
}

- (NSLayoutConstraint *(^)(void))install
{
    return ^id()
    {
        self.view1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constaraint = [NSLayoutConstraint constraintWithItem:self.view1
                                                                       attribute:self.attribute
                                                                       relatedBy:self.relation
                                                                          toItem:self.view2
                                                                       attribute:self.attribute2
                                                                      multiplier:self.multiplier
                                                                        constant:self.constant];
        if (self.view2 == nil) {
            [self.view1 addConstraint:constaraint];
        }
        else
        {
            UIView *superView = [self getClosetCommonSuperViewBetween:self.view1 and:self.view2];
            if (superView) {
                [superView addConstraint:constaraint];
            }
            else
            {
                NSLog(@"there is NO relation between view1(%@) and view2(%@), please recheck!", self.view1.description, self.view2.description);
                assert(0);
            }
        }
        return constaraint;
    };
    
}

#pragma mark - view2
- (LYSimpleLayoutAttribute *(^)(id))lessThanOrEqualTo
{
    return ^id(id view){
        self.relation = NSLayoutRelationLessThanOrEqual;
        self.view2 = view;
        return self;
    };
}

- (LYSimpleLayoutAttribute *(^)(id))equalTo
{
    return ^id(id view){
        self.relation = NSLayoutRelationEqual;
        self.view2 = view;
        return self;
    };
}

- (LYSimpleLayoutAttribute *(^)(id))greaterThanOrEqualTo
{
    return ^id(id view){
        self.relation = NSLayoutRelationGreaterThanOrEqual;
        self.view2 = view;
        return self;
    };
}

#pragma mark - multiplier and constant
- (LYSimpleLayoutAttribute *(^)(CGFloat))multipliedBy
{
    return ^id(CGFloat multiplier){
        self.multiplier *= multiplier;
        return self;
    };
}

- (LYSimpleLayoutAttribute *(^)(CGFloat))offset
{
    return ^id(CGFloat constant){
        self.constant += constant;
        return self;
    };
}

#pragma mark - attribute2
- (LYSimpleLayoutAttribute *)ly_relateToLeft
{
    self.attribute2 = NSLayoutAttributeLeft;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToRight
{
    self.attribute2 = NSLayoutAttributeRight;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToTop
{
    self.attribute2 = NSLayoutAttributeTop;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToBottom
{
    self.attribute2 = NSLayoutAttributeBottom;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToLeading
{
    self.attribute2 = NSLayoutAttributeLeading;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToTrailing
{
    self.attribute2 = NSLayoutAttributeTrailing;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToWidth
{
    self.attribute2 = NSLayoutAttributeWidth;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToHeight
{
    self.attribute2 = NSLayoutAttributeHeight;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToCenterX
{
    self.attribute2 = NSLayoutAttributeCenterX;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToCenterY
{
    self.attribute2 = NSLayoutAttributeCenterY;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToLastBaseline
{
    self.attribute2 = NSLayoutAttributeLastBaseline;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToBaseline
{
    self.attribute2 = NSLayoutAttributeBaseline;
    return self;
}
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
- (LYSimpleLayoutAttribute *)ly_relateToFirstBaseline
{
    self.attribute2 = NSLayoutAttributeFirstBaseline;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToLeftMargin
{
    self.attribute2 = NSLayoutAttributeLeftMargin;
    return self;
}
#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
- (LYSimpleLayoutAttribute *)ly_relateToRightMargin
{
    self.attribute2 = NSLayoutAttributeRightMargin;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToTopMargin
{
    self.attribute2 = NSLayoutAttributeTopMargin;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToBottomMargin
{
    self.attribute2 = NSLayoutAttributeBottomMargin;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToLeadingMargin
{
    self.attribute2 = NSLayoutAttributeLeadingMargin;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToTrailingMargin
{
    self.attribute2 = NSLayoutAttributeTrailingMargin;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToCenterXWithinMargins
{
    self.attribute2 = NSLayoutAttributeCenterXWithinMargins;
    return self;
}
- (LYSimpleLayoutAttribute *)ly_relateToCenterYWithinMargins
{
    self.attribute2 = NSLayoutAttributeCenterYWithinMargins;
    return self;
}
#endif

#pragma mark - TOOL
- (UIView *)getClosetCommonSuperViewBetween:(UIView *)view1 and:(UIView *)view2
{
    UIView *firstView = view1;
    while (firstView) {
        UIView *secondView = view2;
        while (secondView) {
            if (firstView == secondView) {
                return firstView;
            }
            secondView = secondView.superview;
        }
        firstView = firstView.superview;
    }
    return nil;
}

@end

@implementation UIView (LYSimpleLayout)

- (LYSimpleLayoutAttribute *)ly_left
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeft];
}
- (LYSimpleLayoutAttribute *)ly_right
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeRight];
}
- (LYSimpleLayoutAttribute *)ly_top
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeTop];
}
- (LYSimpleLayoutAttribute *)ly_bottom
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeBottom];
}
- (LYSimpleLayoutAttribute *)ly_leading
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeading];
}
- (LYSimpleLayoutAttribute *)ly_trailing
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeTrailing];
}
- (LYSimpleLayoutAttribute *)ly_width
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeWidth];
}
- (LYSimpleLayoutAttribute *)ly_height
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeHeight];
}
- (LYSimpleLayoutAttribute *)ly_centerX
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterX];
}
- (LYSimpleLayoutAttribute *)ly_centerY
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterY];
}
- (LYSimpleLayoutAttribute *)ly_lastBaseline
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeLastBaseline];
}
- (LYSimpleLayoutAttribute *)ly_baseline
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeBaseline];
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
- (LYSimpleLayoutAttribute *)ly_firstBaseline
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeFirstBaseline];
}
- (LYSimpleLayoutAttribute *)ly_leftMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeftMargin];
}
#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
- (LYSimpleLayoutAttribute *)ly_rightMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeRightMargin];
}
- (LYSimpleLayoutAttribute *)ly_topMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeTopMargin];
}
- (LYSimpleLayoutAttribute *)ly_bottomMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeBottomMargin];
}
- (LYSimpleLayoutAttribute *)ly_leadingMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeadingMargin];
}
- (LYSimpleLayoutAttribute *)ly_trailingMargin
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeTrailingMargin];
}
- (LYSimpleLayoutAttribute *)ly_centerXWithinMargins
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterXWithinMargins];
}
- (LYSimpleLayoutAttribute *)ly_centerYWithinMargins
{
    return [[LYSimpleLayoutAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterYWithinMargins];
}
#endif
@end

@implementation NSArray (LYSimpleLayout)
- (NSArray<NSLayoutConstraint *> *(^)(void))install
{
    return ^NSArray<LYSimpleLayoutAttribute *> *(){
        NSMutableArray *resultArray = [NSMutableArray array];
        for (LYSimpleLayoutAttribute *attr in self) {
            [resultArray addObject:attr.install()];
        }
        return resultArray;
    };
}
@end
