//
//  DetailsViewViewModel.m
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import "DetailsViewViewModel.h"

@implementation DetailsViewViewModel

-(instancetype)initWith: (Store *) store {
    self = [super init];
    if (self) {
        self.store = store;
    }
    return self;
}

@end
