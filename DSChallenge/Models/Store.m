//
//  Store.m
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

#import <Foundation/Foundation.h>
#import "Store.h"

@implementation Store

-(instancetype) initWithDictionary:(NSDictionary *)storeDictionary {
    self = [super init];
    if(!self){
        return nil;
    }
    
    //Initializing object from dictionary
    //Check if the given dictionary has an "id" field
    if (storeDictionary[@"id"] == nil) {
        self.storeId = @"";
        NSLog(@"Store has no id.");
    } else {
        self.storeId = storeDictionary[@"id"];
    }
    
    //Check if the given dictionary has an "nome" field
    if (storeDictionary[@"nome"] == nil) {
        self.name = @"";
        NSLog(@"Store has no name.");
    } else {
        self.name = storeDictionary[@"nome"];
    }
    
    //Check if the given dictionary has an "telefone" field
    if (storeDictionary[@"telefone"] == nil) {
        self.phone = @"";
        NSLog(@"Store has no phone.");
    } else {
        self.phone = storeDictionary[@"telefone"];
    }
    
    //Check if the given dictionary has an "endereco" field
    if (storeDictionary[@"endereco"] == nil) {
        self.address = Address.new;
        NSLog(@"Store has no address.");
    } else {
        self.address = [[Address alloc] initWithDictionary:storeDictionary[@"endereco"]];
    }
    
    return self;
}

@end
