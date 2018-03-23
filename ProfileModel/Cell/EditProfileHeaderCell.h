//
//  EditProfileHeaderCell.h
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileModel.h"

@interface EditProfileHeaderCell : UITableViewCell

@property (nonatomic, readonly) UIImageView *avatarImageView;

@property (nonatomic, readonly) UIImageView *editIconView;

@property (nonatomic, readonly) UITextField *nameTF, *genderTF;

- (void)beRelatedModel:(EditProfileModel *)model;

+ (CGFloat)cellHeight;

@end
