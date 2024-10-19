//
//  GitTagModelTests.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//


#import <XCTest/XCTest.h>
#import "GitTagModel.h"

@interface GitTagModelTests : XCTestCase

@end

@implementation GitTagModelTests

- (void)test_initWithDictionary_validDictionary {
    NSDictionary *validDict = @{@"name": @"v1.0"};
    GitTagModel *tag = [[GitTagModel alloc] initWithDictionary:validDict];
    
    XCTAssertEqualObjects(tag.name, @"v1.0");
}

- (void)test_initWithDictionary_emptyDictionary {
    NSDictionary *emptyDict = @{};
    GitTagModel *tag = [[GitTagModel alloc] initWithDictionary:emptyDict];
    
    XCTAssertNil(tag.name);
}

- (void)test_secureCoding {
    NSDictionary *validDict = @{@"name": @"v1.0"};
    GitTagModel *tag = [[GitTagModel alloc] initWithDictionary:validDict];
    
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:tag requiringSecureCoding:YES error:nil];
    GitTagModel *decodedTag = [NSKeyedUnarchiver unarchivedObjectOfClass:[GitTagModel class] fromData:encodedData error:nil];
    
    XCTAssertEqualObjects(decodedTag.name, @"v1.0");
}

@end
