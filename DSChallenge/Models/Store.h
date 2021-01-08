//
//  Store.h
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import <UIKit/UIImage.h>

@interface Store : NSObject

@property NSString *storeId;
@property NSString *name;
@property Address *address;
@property UIImage *image;
@property NSString *phone;

-(instancetype) initWithDictionary: (NSDictionary *) storeDictionary;

@end

