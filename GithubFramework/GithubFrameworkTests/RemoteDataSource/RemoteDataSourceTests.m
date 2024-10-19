//
//  RemoteDataSourceTests.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <XCTest/XCTest.h>
#import "RemoteDataSource.h"
#import "MockNetworkManager.h"
#import "GitHubRepositoryModel.h"
#import "GitTagModel.h"

@interface RemoteDataSourceTests : XCTestCase

@property (nonatomic, strong) RemoteDataSource *remoteDataSource;
@property (nonatomic, strong) MockNetworkManager *mockNetworkManager;

@end

@implementation RemoteDataSourceTests

- (void)setUp {
    [super setUp];
    
    self.mockNetworkManager = [[MockNetworkManager alloc] init];
    self.remoteDataSource = [[RemoteDataSource alloc] initWithNetworkManager:self.mockNetworkManager];
}

- (void)tearDown {
    self.remoteDataSource = nil;
    self.mockNetworkManager = nil;
    
    [super tearDown];
}

- (void)test_getRepositoriesForUser_success {
    // Arrange
    NSArray *mockRepositories = @[@{@"name": @"Repo1"}, @{@"name": @"Repo2"}];
    self.mockNetworkManager.mockRepositories = mockRepositories;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories expectation"];
    
    // Act
    [self.remoteDataSource getRepositoriesForUser:@"testuser" completion:^(NSArray *repositories, NSError *error) {
        // Assert
        XCTAssertNotNil(repositories);
        XCTAssertEqual(repositories.count, 2);
        XCTAssertEqualObjects(repositories[0][@"name"], @"Repo1");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)test_getRepositoriesForUser_failure {
    // Arrange
    NSError *error = [NSError errorWithDomain:@"com.example" code:404 userInfo:nil];
    self.mockNetworkManager.mockError = error;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories error expectation"];

    // Act
    [self.remoteDataSource getRepositoriesForUser:@"testuser" completion:^(NSArray *repositories, NSError *error) {
        // Assert
        XCTAssertNil(repositories);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 404);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)test_getTagsForRepository_success {
    // Arrange
    NSArray *mockTags = @[@{@"name": @"v1.0"}, @{@"name": @"v2.0"}];
    self.mockNetworkManager.mockTags = mockTags;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags expectation"];

    // Act
    [self.remoteDataSource getTagsForRepository:@"https://example.com/tags" completion:^(NSArray *tags, NSError *error) {
        // Assert
        XCTAssertNotNil(tags);
        XCTAssertEqual(tags.count, 2);
        XCTAssertEqualObjects(tags[0][@"name"], @"v1.0");
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)test_getTagsForRepository_failure {
    // Arrange
    NSError *error = [NSError errorWithDomain:@"com.example" code:500 userInfo:nil];
    self.mockNetworkManager.mockError = error;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags error expectation"];

    // Act
    [self.remoteDataSource getTagsForRepository:@"https://example.com/tags" completion:^(NSArray *tags, NSError *error) {
        // Assert
        XCTAssertNil(tags);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 500);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

@end
