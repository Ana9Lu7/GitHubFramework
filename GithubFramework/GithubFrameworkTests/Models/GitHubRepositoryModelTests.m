//
//  GitHubRepositoryModelTests.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//


#import <XCTest/XCTest.h>
#import "GitHubRepositoryModel.h"

@interface GitHubRepositoryModelTests : XCTestCase

@end

@implementation GitHubRepositoryModelTests

- (void)test_initWithDictionary_validDictionary {
    NSDictionary *validDict = @{@"name": @"TestRepo", @"tags_url":  @"https://example.com/tags"};
    GitHubRepositoryModel *repo = [[GitHubRepositoryModel alloc] initWithDictionary:validDict];
    
    XCTAssertEqualObjects(repo.name, @"TestRepo");
    XCTAssertEqualObjects(repo.tagsURL, @"https://example.com/tags");
}

- (void)test_initWithDictionary_emptyDictionary {
    NSDictionary *emptyDict = @{};
    GitHubRepositoryModel *repo = [[GitHubRepositoryModel alloc] initWithDictionary:emptyDict];
    
    XCTAssertNil(repo.name);
    XCTAssertNil(repo.tagsURL);
}

- (void)test_secureCoding {
    NSDictionary *validDict = @{@"name": @"TestRepo", @"tags_url": @"https://example.com/tags"};
    GitHubRepositoryModel *repo = [[GitHubRepositoryModel alloc] initWithDictionary:validDict];
    
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:repo requiringSecureCoding:YES error:nil];
    GitHubRepositoryModel *decodedRepo = [NSKeyedUnarchiver unarchivedObjectOfClass:[GitHubRepositoryModel class] fromData:encodedData error:nil];
    
    XCTAssertEqualObjects(decodedRepo.name, @"TestRepo");
    XCTAssertEqualObjects(decodedRepo.tagsURL, @"https://example.com/tags");
}

@end
