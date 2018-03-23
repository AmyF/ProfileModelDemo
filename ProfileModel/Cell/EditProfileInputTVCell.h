//
//  EditProfileInputTVCell.h
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileModel.h"

@protocol EditProfileTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)tableView:(UITableView *)tableView textViewDidChangeSelection:(UITextView*)textView;
- (void)tableView:(UITableView *)tableView textViewDidEndEditing:(UITextView*)textView;
@end

@interface EditProfileInputTVCell : UITableViewCell

@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, readonly) UITextView *textView;
@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic) NSString *text;

- (void)updateTextViewHeight; // Call to update the textView height (useful for viewdidload)

- (void)beRelatedItem:(EditProfileItem *)item;

@end


