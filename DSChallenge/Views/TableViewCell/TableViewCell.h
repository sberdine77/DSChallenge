//
//  TableViewCell.h
//  DSChallenge
//
//  Created by Sávio Berdine on 08/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

NS_ASSUME_NONNULL_END
