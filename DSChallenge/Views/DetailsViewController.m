//
//  DetailsViewController.m
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

-(instancetype) initWithViewModel: (DetailsViewViewModel *) viewModel {
    self = [super initWithNibName:nil bundle:nil];
        if (!self) {
            return nil;
        }
        self.viewModel = viewModel;
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
