//
//  EditProfileModel.h
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileItemType.h"

@class ProfileModel;

@interface EditProfileItem : NSObject

@property (nonatomic, readonly) ProfileItemType type;

@property (nonatomic, copy) id value;

@property (nonatomic, copy, readonly) id originValue;

@property (nonatomic, copy) NSAttributedString *title;

@property (nonatomic, copy) NSAttributedString *placeholder;

@property (nonatomic) BOOL editable;

@property (nonatomic) CGFloat cellHeight;

+ (instancetype)createWithType:(ProfileItemType)type originValue:(id)originValue;

- (BOOL)changed;

@end

@interface EditProfileModel : NSObject

- (instancetype)initWithProfile:(ProfileModel *)profile;

- (NSInteger)numberOfSection;

- (NSInteger)numberOfRowInSection:(NSInteger)section;

- (EditProfileItem *)itemOfType:(ProfileItemType)type;

- (EditProfileItem *)itemOfIndexPath:(NSIndexPath *)indexPath;

- (NSArray<EditProfileItem *> *)editItems;

- (BOOL)changed;

- (BOOL)changedInType:(ProfileItemType)type;


@end
