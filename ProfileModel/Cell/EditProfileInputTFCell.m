//
//  EditProfileInputTFCell.m
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import "EditProfileInputTFCell.h"

@interface EditProfileInputTFCell ()

@property (nonatomic, weak) EditProfileItem *item;

@end

@implementation EditProfileInputTFCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _inputTF = [[UITextField alloc] init];
        [_inputTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
        [_inputTF setTextColor:[UIColor blackColor]];
        [_inputTF setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:_inputTF];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)beRelatedItem:(EditProfileItem *)item {
    _item = item;
    [_inputTF setEnabled:item.editable];
    
    [_titleLabel setAttributedText:item.title];
    [_inputTF setAttributedPlaceholder:item.placeholder];
    
    [_inputTF setText:item.value];
    
    [item setCellHeight:[EditProfileInputTFCell cellHeight]];
}

- (void)textChanged {
    _item.value = _inputTF.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    
    [_titleLabel setFrame:CGRectMake(15, 15, 90, 20)];
    [_inputTF setFrame:CGRectMake(15+90, 15, width - 15-90, 20)];
}

+ (CGFloat)cellHeight {
    return 15+20+15;
}

@end
