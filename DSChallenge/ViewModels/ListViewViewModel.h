//
//  ListViewViewModel.h
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"
#import "Store.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<Store *> *storesArray; //Collection of Store objects
@property (nonatomic, assign) BOOL loadingStores;

-(instancetype)initWith: (DetailsViewController * (^)(Store* store))viewForSelectedStore;
-(void) getAllStores;

@end

NS_ASSUME_NONNULL_END
