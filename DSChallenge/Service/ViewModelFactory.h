//
//  ViewModelFactory.h
//  DSChallenge
//
//  Created by Sávio Berdine on 08/01/21.
//

#import <Foundation/Foundation.h>
#import "ListViewViewModel.h"
#import "DetailsViewViewModel.h"
#import "DetailsViewController.h"
#import "Store.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModelFactory : NSObject

-(ListViewViewModel *) makeListViewViewModel;
-(DetailsViewViewModel *) makeDetailsViewViewModel: (Store *) store;

@end

NS_ASSUME_NONNULL_END
