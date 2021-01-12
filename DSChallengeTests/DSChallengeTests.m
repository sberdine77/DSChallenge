//
//  DSChallengeTests.m
//  DSChallengeTests
//
//  Created by Sávio Berdine on 05/01/21.
//

#import <XCTest/XCTest.h>
#import "Address.h"
#import "Store.h"
#import "DetailsViewViewModel.h"

@interface DSChallengeTests : XCTestCase

@property (nonatomic) Address *addressInstanceToTest;

@end

@implementation DSChallengeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.addressInstanceToTest = [[Address alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testInitAddressWithSemiEmptyDictionary {
    NSDictionary *dic = @{@"logradouro": @"rua"};
    Address *outAddress = [self.addressInstanceToTest initWithDictionary:dic];
    Address *expectedAddress = [[Address alloc] initAddressWithStreet:@"rua" andNumber:@"" andNeighborhood:@"" andComplement:@""];
    
    XCTAssertEqual(expectedAddress.street, outAddress.street, @"The address created with empty dictionary was not initialized correctly (with empty strings)");
    
}

-(void)testAddressURLFormat {
    NSDictionary *addDic = @{@"complemento": @"",
                             @"bairro": @"Bairro Camera",
                             @"numero": @"01",
                             @"logradouro": @"Rua de teste 01"};
    NSDictionary *dic = @{@"id": @"1",
                          @"endereco": addDic,
                          @"nome": @"Android Stduio",
                          @"telefone": @"(81) 3465-0787"};
    Store *stor = [[Store alloc] initWithDictionary:dic];
    DetailsViewViewModel *dVM = [[DetailsViewViewModel alloc] initWith:stor];
    [dVM directionsToStore:^(NSMutableArray * _Nonnull result) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
            NSString *str = [NSString stringWithFormat:@"%@", result[0][1]];
            NSString *str2 = [NSString stringWithFormat:@"%@", @"comgooglemaps://?daddr=Rua%20de%20teste%2001%2001%20%20Bairro%20Camera&directionsmode=driving"];
            XCTAssertEqualObjects(str.stringByRemovingPercentEncoding, str2.stringByRemovingPercentEncoding, @"The URL to be sent to Google Maps is malformed");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: @"http://maps.apple.com/"]]) {
                NSString *str3 = [NSString stringWithFormat:@"%@", result[1][1]];
                NSString *str4 = [NSString stringWithFormat:@"%@", @"http://maps.apple.com/?daddr=Rua%20de%20teste%2001%2001%20%20Bairro%20Camera&dirflg=d"];
                
                XCTAssertEqualObjects(str3.stringByRemovingPercentEncoding, str4.stringByRemovingPercentEncoding, @"The URL to be sent to Apple Maps is malformed");
            }
        } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: @"http://maps.apple.com/"]]) {
            NSString *str = [NSString stringWithFormat:@"%@", result[0][1]];
            NSString *str2 = [NSString stringWithFormat:@"%@", @"http://maps.apple.com/?daddr=Rua%20de%20teste%2001%2001%20%20Bairro%20Camera&dirflg=d"];
            
            XCTAssertEqualObjects(str.stringByRemovingPercentEncoding, str2.stringByRemovingPercentEncoding, @"The URL to be sent to Apple Maps is malformed");
        }
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
