//
//  EditProfileViewController.m
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import "EditProfileViewController.h"
#import "EditProfileHeaderCell.h"
#import "EditProfileInputTVCell.h"
#import "EditProfileInputTFCell.h"
#import "ProfileModel.h"
#import "EditProfileModel.h"

#define HCellID @"HCellID"
#define TVCellID @"TVCellID"
#define TFCellID @"TFCellID"

@interface EditProfileViewController () <EditProfileTableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *eTableView;

@property (nonatomic) EditProfileModel *editModel;

@end

@implementation EditProfileViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _editModel = [[EditProfileModel alloc] initWithProfile:[ProfileModel sharedInstance]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                               style:UITableViewStyleGrouped];
    [_eTableView setDelegate:self];
    [_eTableView setDataSource:self];
    [_eTableView setEstimatedRowHeight:[EditProfileInputTFCell cellHeight]];
    [_eTableView registerClass:[EditProfileHeaderCell class] forCellReuseIdentifier:HCellID];
    [_eTableView registerClass:[EditProfileInputTFCell class] forCellReuseIdentifier:TFCellID];
    [_eTableView registerClass:[EditProfileInputTVCell class] forCellReuseIdentifier:TVCellID];
    [self.view addSubview:_eTableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(tappedDone)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)tappedDone {
    [[ProfileModel sharedInstance] updateFromEditModel:_editModel];
    [[ProfileModel sharedInstance] saveToLocal];
    [[ProfileModel sharedInstance] saveToServerWithHandler:^(BOOL result, NSString *msg) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_editModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_editModel numberOfRowInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditProfileItem *item = [_editModel itemOfIndexPath:indexPath];
    switch (item.type) {
        case ProfileItem_Avatar:
        case ProfileItem_Name:
        case ProfileItem_Gender: {
            return [EditProfileHeaderCell cellHeight];
        }
        case ProfileItem_AboutMe: {
            return MAX([EditProfileInputTFCell cellHeight], item.cellHeight);
        }
        default: {
            return [EditProfileInputTFCell cellHeight];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditProfileItem *item = [_editModel itemOfIndexPath:indexPath];
    switch (item.type) {
        case ProfileItem_Avatar:
        case ProfileItem_Name:
        case ProfileItem_Gender: {
            EditProfileHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:HCellID forIndexPath:indexPath];
            [cell beRelatedModel:_editModel];
            return cell;
        }
        case ProfileItem_AboutMe: {
            EditProfileInputTVCell *cell = [tableView dequeueReusableCellWithIdentifier:TVCellID forIndexPath:indexPath];
            [cell beRelatedItem:[_editModel itemOfIndexPath:indexPath]];
            [cell setExpandableTableView:tableView];
            return cell;
        }
        default: {
            EditProfileInputTFCell *cell = [tableView dequeueReusableCellWithIdentifier:TFCellID forIndexPath:indexPath];
            [cell beRelatedItem:item];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath {}

@end
