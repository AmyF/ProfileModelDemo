//
//  EditProfileHeaderCell.m
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import "EditProfileHeaderCell.h"

@interface EditProfileHeaderCell ()

@property (nonatomic) UIView *middleline;

@property (nonatomic, weak) EditProfileItem *avatarItem, *nameItem, *genderItem;

@end

@implementation EditProfileHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 78, 78)];
        [_avatarImageView setUserInteractionEnabled:YES];
        [_avatarImageView.layer setCornerRadius:78/2];
        [_avatarImageView.layer setMasksToBounds:YES];
        [self.contentView addSubview:_avatarImageView];
        
        _editIconView = [[UIImageView alloc] init];
        
        _nameTF = [[UITextField alloc] init];
        [_nameTF setTextColor:[UIColor blackColor]];
        [_nameTF setFont:[UIFont systemFontOfSize:15]];
        [_nameTF addTarget:self action:@selector(nameChanged) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_nameTF];
        
        _genderTF = [[UITextField alloc] init];
        [_genderTF setTextColor:[UIColor lightGrayColor]];
        [_genderTF setFont:[UIFont systemFontOfSize:15]];
        [_genderTF setEnabled:NO];
        [_genderTF addTarget:self action:@selector(phoneChanged) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_genderTF];
        
        _middleline = [[UIView alloc] init];
        [_middleline setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_middleline];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)beRelatedModel:(EditProfileModel *)model {
    _avatarItem = [model itemOfType:ProfileItem_Avatar];
    if ([_avatarItem.value isKindOfClass:[NSString class]]) {
        NSURL *url = [NSURL URLWithString:_avatarItem.value];
        // TODO: 使用网络图片加载库完善
    }
    else if ([_avatarItem.value isKindOfClass:[UIImage class]]) {
        [_avatarImageView setImage:_avatarItem.value];
    }
    else {
        [_avatarImageView setImage:[UIImage imageNamed:@"public_avatar"]];
    }
    
    _nameItem = [model itemOfType:ProfileItem_Name];
    [_nameTF setText:_nameItem.value];
    [_nameTF setEnabled:_nameItem.editable];
    
    _genderItem = [model itemOfType:ProfileItem_Gender];
    [_genderTF setText:[self convertGender:(Gender)[_genderItem.value integerValue]]];
    [_genderTF setEnabled:_genderItem.editable];
    
    [_avatarItem setCellHeight:[EditProfileHeaderCell cellHeight]];
    [_nameItem setCellHeight:[EditProfileHeaderCell cellHeight]];
    [_genderItem setCellHeight:[EditProfileHeaderCell cellHeight]];
}

- (NSString *)convertGender:(Gender)gender {
    switch (gender) {
        case Gender_Male:
            return @"男";
        case Gender_Female:
            return @"女";
        case Gender_Unknown:
            return @"未知";
    }
}

- (void)nameChanged {
    _nameItem.value = _nameTF.text;
}

- (void)phoneChanged {
    _genderItem.value = _genderTF.text;
}

- (void)avatarChanged {
    _avatarItem.value = _avatarImageView.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    [_avatarImageView setFrame:CGRectMake(15, 15, 78, 78)];
    [_nameTF setFrame:CGRectMake(15+78+15, 0, width - 15-78-15, height/2)];
    [_genderTF setFrame:CGRectMake(15+78+15, height/2, width - 15-78-15, height/2)];
    [_middleline setFrame:CGRectMake(15+78+15, height/2-0.5, width - 15-78-15, 0.5)];
}

+ (CGFloat)cellHeight {
    return 15+78+15;
}

@end
