//
//  EditProfileInputTVCell.m
//  LemoCard
//
//  Created by MGM on 2018/3/20.
//  Copyright © 2018年 spa. All rights reserved.
//

#import "EditProfileInputTVCell.h"

#define kPadding 16

@interface EditProfileInputTVCell () <UITextViewDelegate>

@property (nonatomic) UITextView *textView;
@property (nonatomic) UILabel *titleLabel;

@property (nonatomic, weak) EditProfileItem *item;

@end

@implementation EditProfileInputTVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)beRelatedItem:(EditProfileItem *)item {
    _item = item;
    [_titleLabel setAttributedText:item.title];
    // TODO: 使用带有Placeholder的TextView替代原生
    
    [_textView setEditable:item.editable];
    
    [self setText:item.value];
}

- (void)textChanged {
    _item.value = _textView.text;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, kPadding, 90, 20)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (_textView == nil) {
        CGRect tvFrame = CGRectMake(15+90,
                                    kPadding,
                                    CGRectGetWidth(self.bounds) - 15-90-20,
                                    20);
        _textView = [[UITextView alloc] initWithFrame:tvFrame];
        _textView.delegate = self;
        
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:15];
        
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.textContainerInset = UIEdgeInsetsZero;
    }
    return _textView;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI and the cell size with a delay to allow the cell to load
    self.textView.text = text;
    [self performSelector:@selector(textViewDidChange:)
               withObject:self.textView
               afterDelay:0.1];
}

- (CGFloat)cellHeight
{
    return MAX(20,[self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height) + kPadding * 2;
}

- (void)updateTextViewHeight {
    [self textViewDidChange:self.textView];
}

#pragma mark - Text View Delegate

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidEndEditing:)]) {
        [(id<EditProfileTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidEndEditing:self.textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidChangeSelection:)]) {
        [(id<EditProfileTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidChangeSelection:self.textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textView:shouldChangeTextInRange:replacementText:)]) {
        id<EditProfileTableViewDelegate> delegate = (id<EditProfileTableViewDelegate>)self.expandableTableView.delegate;
        return [delegate tableView:self.expandableTableView
                          textView:textView
           shouldChangeTextInRange:range
                   replacementText:text];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [(id<EditProfileTableViewDelegate>)self.expandableTableView.delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    [self textChanged];
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(EditProfileTableViewDelegate)]) {
        
        id<EditProfileTableViewDelegate> delegate = (id<EditProfileTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        _text = self.textView.text;
        
        [_item setValue:_text];
        
        CGFloat newHeight = [self cellHeight];
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            CGRect tvFrame = CGRectMake(15+90,
                                        kPadding,
                                        CGRectGetWidth(self.bounds) - 15-90-20,
                                        newHeight - kPadding * 2);
            [_textView setFrame:tvFrame];
            [_item setCellHeight:newHeight];
            // update the height
            if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
                [delegate tableView:self.expandableTableView
                      updatedHeight:newHeight
                        atIndexPath:indexPath];
            }
            
            // refresh the table without closing the keyboard
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
    }
}

@end




