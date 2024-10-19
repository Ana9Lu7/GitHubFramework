//
//  NetworkManagerTests.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <XCTest/XCTest.h>
#import "NetworkManager.h"

@interface NetworkManagerTests : XCTestCase
@end

@implementation NetworkManagerTests

- (void)test_sharedManager_returnsSameInstance {
    NetworkManager *firstInstance = [NetworkManager sharedManager];
    NetworkManager *secondInstance = [NetworkManager sharedManager];

    XCTAssertEqual(firstInstance, secondInstance, @"The sharedManager should return the same instance every time it is called.");
}

@end
