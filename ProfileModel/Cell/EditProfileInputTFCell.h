//
//  EditProfileInputTFCell.h
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileModel.h"

@interface EditProfileInputTFCell : UITableViewCell

@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, readonly) UITextField *inputTF;

- (void)beRelatedItem:(EditProfileItem *)item;

+ (CGFloat)cellHeight;

@end
