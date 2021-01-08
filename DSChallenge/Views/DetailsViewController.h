//
//  DetailsViewController.h
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import <UIKit/UIKit.h>
#import "DetailsViewViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property DetailsViewViewModel *viewModel;

-(instancetype) initWithViewModel: (DetailsViewViewModel *) viewModel;

@end

NS_ASSUME_NONNULL_END
