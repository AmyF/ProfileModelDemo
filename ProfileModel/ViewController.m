//
//  ViewController.m
//  ProfileModel
//
//  Created by MGM on 2018/3/24.
//  Copyright © 2018年 unko. All rights reserved.
//

#import "ViewController.h"
#import "EditProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [button setCenter:self.view.center];
    [button setTitle:@"按下去啊" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(tappedButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)tappedButton {
    EditProfileViewController *vc = [[EditProfileViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
