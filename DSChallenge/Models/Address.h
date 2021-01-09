//
//  Address.h
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

@interface Address : NSObject

@property NSString *street;
@property NSString *number;
@property NSString *neighborhood;
@property NSString *complement;

-(instancetype) initWithDictionary: (NSDictionary *) addressDictionary;

/*Init address directely with strings*/
-(Address*) initAddressWithStreet: (NSString*) street andNumber: (NSString*) number andNeighborhood: (NSString*) neighborhood andComplement: (NSString*) complement;

@end

