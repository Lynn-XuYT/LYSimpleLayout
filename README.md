# LYSimpleLayout

## for example ##

```
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    [superview addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [superview addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor greenColor];
    [superview addSubview:view3];
    
    // example 1
    view1.ly_top.equalTo(superview).ly_relateToTop.install();
    view1.ly_left.equalTo(superview).ly_relateToLeft.install();
    view1.ly_width.equalTo(superview).ly_relateToWidth.offset(-100).install();
    view1.ly_height.equalTo(superview).ly_relateToHeight.offset(-200).install();
    
    // example 2
    view2.ly_top.equalTo(view1).ly_relateToBottom.install();
    view2.ly_left.equalTo(superview).ly_relateToLeft.install();
    view2.ly_width.offset(100).install();
    view2.ly_bottom.equalTo(superview).ly_relateToBottom.offset(-10).install();
    
    // example 3
    @[view3.ly_top.equalTo(view2).ly_relateToTop,
      view3.ly_left.equalTo(view2).ly_relateToRight.offset(40),
      view3.ly_width.equalTo(view2).ly_relateToWidth.multipliedBy(2),
      view3.ly_bottom.equalTo(superview).ly_relateToBottom.offset(-10)].install();
```

