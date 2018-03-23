//
//  ProfileModel.h
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ProfileItem) {
    ProfileItem_Name,
    ProfileItem_UID,
    ProfileItem_Avatar,
    ProfileItem_AboutMe,
};

@interface ProfileModel : NSObject

@end
