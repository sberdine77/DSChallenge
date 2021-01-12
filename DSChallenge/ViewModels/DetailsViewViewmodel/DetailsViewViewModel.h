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
//@property (nonatomic, assign) NSMutableArray *installedNavigationApps;

-(instancetype)initWith: (Store *) store;
-(void)fetchStoreImage;
-(void) saveStoreImage: (UIImage *)image;
-(void) callStore: (void (^)(NSString * _Nullable result, NSError * _Nullable error))callTo;
-(void) directionsToStore: (void (^)(NSMutableArray * result))availableMaps;

@end

NS_ASSUME_NONNULL_END
