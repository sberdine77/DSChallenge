//
//  Address.m
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

#import <Foundation/Foundation.h>
#import "Address.h"

@implementation Address

-(instancetype) initWithDictionary: (NSDictionary *) addressDictionary {
    self = [super init];
    if(!self){
        return nil;
    }
    
    //Initializing object from dictionary
    //Check if the given dictionary has an "logradouro" field
    if (addressDictionary[@"logradouro"] == nil) {
        self.street = @"";
        NSLog(@"Address has no street");
    } else {
        self.street = addressDictionary[@"logradouro"];
    }
    
    //Check if the given dictionary has an "numero" field
    if (addressDictionary[@"numero"] == nil) {
        self.number = @"";
        NSLog(@"Address has no number");
    } else {
        self.number = addressDictionary[@"numero"];
    }
    
    //Check if the given dictionary has an "bairro" field
    if (addressDictionary[@"bairro"] == nil) {
        self.neighborhood = @"";
        NSLog(@"Address has no neighborhood");
    } else {
        self.neighborhood = addressDictionary[@"bairro"];
    }
    
    //Check if the given dictionary has an "complemento" field
    if (addressDictionary[@"complemento"] == nil) {
        self.complement = @"";
        NSLog(@"Address has no complement");
    } else {
        self.complement = addressDictionary[@"complemento"];
    }
    
    return self;
}

@end
