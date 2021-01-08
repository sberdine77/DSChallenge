//
//  DetailsViewViewModel.h
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import <Foundation/Foundation.h>
#import "Store.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewViewModel : NSObject

@property Store *store;

-(instancetype)initWith: (Store *) store;

@end

NS_ASSUME_NONNULL_END
