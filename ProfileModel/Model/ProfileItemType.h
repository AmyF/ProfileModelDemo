//
//  ProfileItem.h
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#ifndef ProfileItem_h
#define ProfileItem_h

typedef NS_ENUM(NSUInteger, ProfileItemType) {
    ProfileItem_Name,
    ProfileItem_UID,
    ProfileItem_Avatar,
    ProfileItem_Gender,
    ProfileItem_AboutMe,
};

typedef NS_ENUM(NSUInteger, Gender) {
    Gender_Unknown,
    Gender_Male,
    Gender_Female,
};

#endif /* ProfileItem_h */
