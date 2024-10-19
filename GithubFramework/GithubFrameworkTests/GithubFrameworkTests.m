//
//  GithubFrameworkTests.m
//  GithubFrameworkTests
//
//  Created by Ana Luiza on 18/10/24.
//

#import <XCTest/XCTest.h>
#import "GithubFramework.h"
#import "MockRemoteDataSource.h"
#import "MockLocalDataSource.h"

@interface GithubFrameworkTests : XCTestCase

@property (nonatomic, strong) GithubFramework *githubFramework;
@property (nonatomic, strong) MockRemoteDataSource *mockRemoteDataSource;
@property (nonatomic, strong) MockLocalDataSource *mockLocalDataSource;

@end

@implementation GithubFrameworkTests

- (void)setUp {
    [super setUp];
    self.githubFramework = [GithubFramework sharedManager];

    self.mockRemoteDataSource = [[MockRemoteDataSource alloc] init];
    self.mockLocalDataSource = [[MockLocalDataSource alloc] init];

    [self.githubFramework setRemoteDataSource:self.mockRemoteDataSource localDataSource:self.mockLocalDataSource];
}

- (void)tearDown {
    self.githubFramework = nil;
    self.mockRemoteDataSource = nil;
    self.mockLocalDataSource = nil;
    [super tearDown];
}

// MARK: - fetchRepositoriesForUser

- (void)test_fetchRepositoriesForUser_success {
    NSArray *mockRepos = @[@{@"name": @"TestRepo", @"tags_url": @"https://example.com/tags"}];
    self.mockRemoteDataSource.mockRepositories = mockRepos;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories expectation"];
    
    [self.githubFramework fetchRepositoriesForUser:@"testUser" completion:^(NSArray *repositories, NSError *error) {
        XCTAssertNotNil(repositories);
        XCTAssertEqual(repositories.count, 1);
        XCTAssertEqualObjects(repositories[0][@"name"], @"TestRepo");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)test_fetchRepositoriesForUser_error {
    NSError *mockError = [NSError errorWithDomain:@"com.example" code:404 userInfo:nil];
    self.mockRemoteDataSource.mockError = mockError;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch repositories error expectation"];
    
    [self.githubFramework fetchRepositoriesForUser:@"testUser" completion:^(NSArray *repositories, NSError *error) {
        XCTAssertNil(repositories);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 404);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

// MARK: - fetchRepositoriesTag

- (void)test_fetchRepositoriesTag_success {
    NSArray *mockTags = @[@{@"name": @"v1.0"}];
    self.mockRemoteDataSource.mockTags = mockTags;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags expectation"];
    
    [self.githubFramework fetchRepositoriesTag:@"https://example.com/tags" completion:^(NSArray *tags, NSError *error) {
        XCTAssertNotNil(tags);
        XCTAssertEqual(tags.count, 1);
        XCTAssertEqualObjects(tags[0][@"name"], @"v1.0");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}


- (void)test_fetchRepositoriesTag_error {
    NSError *mockError = [NSError errorWithDomain:@"com.example" code:404 userInfo:nil];
    self.mockRemoteDataSource.mockError = mockError;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch tags error expectation"];
    
    [self.githubFramework fetchRepositoriesTag:@"https://example.com/tags" completion:^(NSArray *tags, NSError *error) {
        XCTAssertNil(tags);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 404);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

@end
