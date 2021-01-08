//
//  ViewController.h
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

#import <UIKit/UIKit.h>
#import "ListViewViewModel.h"

@interface ListViewController : UITableViewController

@property ListViewViewModel *viewModel;

-(instancetype) initWithViewModel: (ListViewViewModel *) viewModel;

@end

