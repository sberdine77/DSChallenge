//
//  TableViewCell.m
//  DSChallenge
//
//  Created by Sávio Berdine on 08/01/21.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
