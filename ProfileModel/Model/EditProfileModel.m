//
//  EditProfileModel.m
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import "EditProfileModel.h"
#import "ProfileModel.h"

@implementation EditProfileItem

+ (instancetype)createWithType:(ProfileItemType)type originValue:(id)originValue {
    return [[EditProfileItem alloc] initWithType:type originValue:originValue];
}

- (instancetype)initWithType:(ProfileItemType)type originValue:(id)originValue {
    self = [super init];
    if (self) {
        _type = type;
        _value = originValue;
        _originValue = originValue;
        _editable = YES;
    }
    return self;
}

- (BOOL)changed {
    return ![_value isEqual:_originValue];
}

@end

@interface EditProfileModel ()

@property (nonatomic) NSArray<NSArray<EditProfileItem *> *> *dataSource;

@end

@implementation EditProfileModel

- (instancetype)initWithProfile:(ProfileModel *)profile {
    self = [super init];
    if (self) {
        [self initDataFromProfile:profile];
    }
    return self;
}

- (void)initDataFromProfile:(ProfileModel *)profile {
    EditProfileItem *avatarItem = [EditProfileItem createWithType:ProfileItem_Avatar originValue:profile.avatar];
    EditProfileItem *nameItem = [EditProfileItem createWithType:ProfileItem_Name originValue:profile.name];
    EditProfileItem *genderItem = [EditProfileItem createWithType:ProfileItem_Gender originValue:[@(profile.gender) stringValue]];
    [genderItem setEditable:NO];
    
    EditProfileItem *aboutMeItem = [self createNormalItem:ProfileItem_AboutMe value:profile.aboutMe title:@"自我简介" placeholder:@""];
    
    _dataSource = @[
                    @[avatarItem,nameItem,genderItem],
                    @[aboutMeItem],
                    ];
}

- (EditProfileItem *)createNormalItem:(ProfileItemType)type
                                value:(id)value
                                title:(NSString *)title
                          placeholder:(NSString *)placeholder {
    EditProfileItem *item = [EditProfileItem createWithType:type originValue:value];
    [item setTitle:[[NSAttributedString alloc] initWithString:title
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [item setPlaceholder:[[NSAttributedString alloc] initWithString:placeholder
                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}]];
    return item;
}

- (NSInteger)numberOfSection {
    return [_dataSource count];
}

- (NSInteger)numberOfRowInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [_dataSource[section] count];
}

- (EditProfileItem *)itemOfType:(ProfileItemType)type {
    for (NSArray<EditProfileItem *> *array in _dataSource) {
        for (EditProfileItem *item in array) {
            if (item.type == type) {
                return item;
            }
        }
    }
    return nil;
}

- (EditProfileItem *)itemOfIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }
    return _dataSource[indexPath.section][indexPath.row];
}

- (NSArray<EditProfileItem *> *)editItems {
    NSMutableArray *result = [NSMutableArray array];
    for (NSArray<EditProfileItem *> *array in _dataSource) {
        [result addObjectsFromArray:array];
    }
    return result;
}

- (BOOL)changed {
    for (NSArray<EditProfileItem *> *array in _dataSource) {
        for (EditProfileItem *item in array) {
            if ([item changed]) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)changedInType:(ProfileItemType)type {
    EditProfileItem *item = [self itemOfType:type];
    return [item changed];
}

@end
