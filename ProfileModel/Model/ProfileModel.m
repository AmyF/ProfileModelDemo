//
//  ProfileModel.m
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import "ProfileModel.h"
#import "EditProfileModel.h"

@interface ProfileModel ()

@property (nonatomic, copy) NSString *uid;

@end

@implementation ProfileModel

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithUID:@"100000"];
    });
    return instance;
}

- (instancetype)initWithUID:(NSString *)uid {
    self = [super init];
    if (self) {
        self.uid = uid;
        
        // 这一步可以去掉，为了方便在这里加上
        // 在初始化一个Profile对象时更新一下数据
        [self updateFromLocal];
    }
    return self;
}

- (BOOL)isValid {
    return _name.length > 0 && _uid.length > 0;
}

- (void)updateFromLocal {
    // TODO: 一般在这里从数据库读取数据
}

- (void)updateFromServerWithHandler:(ProfileCompletionHandler)handler {
    // TODO: 这里是从服务器更新数据
}

- (void)updateFromEditModel:(EditProfileModel *)model {
    NSArray<EditProfileItem *> *items = [model editItems];
    for (EditProfileItem *item in items) {
        switch (item.type) {
            case ProfileItem_AboutMe:
                self.aboutMe = item.value;
                break;
            case ProfileItem_Avatar:
                if ([item.value isKindOfClass:[NSString class]]) {
                    self.avatar = item.value;
                }
                break;
            case ProfileItem_Gender:
                self.gender = (Gender)[item.value integerValue];
                break;
            case ProfileItem_Name:
                self.name = item.value;
            case ProfileItem_UID:
                break;
        }
    }
}

- (void)saveToLocal {
    // TODO: 一般在这里写入数据库
}

- (void)saveToServerWithHandler:(ProfileCompletionHandler)handler {
    // TODO: 在这里从服务器拉取数据，
    // 如果需要储存到本地，在外部主动调用 saveToLocal 方法
}

@end

NSNotificationName const ProfileWillUpdateNotification = @"ProfileWillUpdateNotification";
NSNotificationName const ProfileDidUpdateNotification = @"ProfileDidUpdateNotification";












