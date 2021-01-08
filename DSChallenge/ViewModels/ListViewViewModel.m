//
//  ListViewViewModel.m
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import "ListViewViewModel.h"

@interface ListViewViewModel ()

@property NSString *allStoresUrl; //API url to fetch all stores

@end

@implementation ListViewViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loadingStores = true;
    }
    return self;
}

-(void) getAllStores {
    self.allStoresUrl = @"https://raw.githubusercontent.com/mateuscp/DSChallengeiOS/main/jsonRequest.json";
    NSURL *url = [NSURL URLWithString: self.allStoresUrl];
    self.storesArray = [[NSMutableArray alloc] init];
    
    if (self.loadingStores == false) {
        self.loadingStores = true;
    }
    
    //API request:
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Stores fetched from api...");
        
        //Cast the data returned to JSON format
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
        
        //Serialize JSON to NSDictonary
        NSError *err;
        NSDictionary *dataReturned = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingAllowFragments error:&err];

        if (error) {
            NSLog(@"Failed to serialise data to JSON: %@", err);
            return;
        }
        
        if (dataReturned[@"lojas"] == nil) {
            NSLog(@"There is no store in api.");
            return;
        }
        
        //Catch the dictionary of stores on the "lojas" key
        NSDictionary *storesDic = dataReturned[@"lojas"];
        if (storesDic == nil) {
            NSLog(@"Data malformed");
        }
        
        //Add fetched stores to the storesArray
        for (NSDictionary *dic in storesDic) {
            Store *singleStore = [[Store alloc] initWithDictionary:dic];
            [self.storesArray addObject:singleStore];
        }
        self.loadingStores = false;
        
        for (Store* stor in self.storesArray) {
            NSLog(@"Store %@", stor);
        }
        
    }] resume];
}

@end
