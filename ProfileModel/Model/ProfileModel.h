//
//  ProfileModel.h
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileItemType.h"

// 这是拉去/写入数据到服务器的Block，根据自身业务进行修改
typedef void(^ProfileCompletionHandler)(BOOL result, NSString *msg);

@class EditProfileModel;

@interface ProfileModel : NSObject

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic) Gender gender;

@property (nonatomic, copy) NSString *aboutMe;

+ (instancetype)sharedInstance;

- (instancetype)initWithUID:(NSString *)uid;

- (BOOL)isValid;

- (void)updateFromLocal;

- (void)updateFromServerWithHandler:(ProfileCompletionHandler)handler;

- (void)updateFromEditModel:(EditProfileModel *)model;

- (void)saveToLocal;

- (void)saveToServerWithHandler:(ProfileCompletionHandler)handler;

@end



extern NSNotificationName const ProfileWillUpdateNotification;
extern NSNotificationName const ProfileDidUpdateNotification;






