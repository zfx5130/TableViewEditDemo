//
//  TestTableViewCell.m
//  TableViewEditDemo
//
//  Created by 赵富星 on 16/8/17.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated {
    [super setEditing:editing
             animated:YES];
    if (editing) {
        for (UIView * view in self.subviews) {
            if ([NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
                for (UIView * subview in view.subviews) {
                    if ([subview isKindOfClass: [UIImageView class]]) {
                        CGRect frame = subview.frame;
                        frame.size.width += 10;
                        frame.size.height += 15;
                        subview.frame = frame;
                        ((UIImageView *)subview).image = [UIImage imageNamed: @"edit_image"];
                    }
                }
            }
        }
    }
}

@end
