//
//  ViewModelFactory.m
//  DSChallenge
//
//  Created by Sávio Berdine on 08/01/21.
//

#import "ViewModelFactory.h"

@implementation ViewModelFactory

-(ListViewViewModel *) makeListViewViewModel {
    return [[ListViewViewModel alloc] initWith:^DetailsViewController * _Nonnull(Store * _Nonnull store) {
        return [[DetailsViewController alloc] initWithViewModel:[self makeDetailsViewViewModel:store]];
    }];
}
-(DetailsViewViewModel *) makeDetailsViewViewModel: (Store *) store {
    return [[DetailsViewViewModel alloc] initWith:store];
}

@end
