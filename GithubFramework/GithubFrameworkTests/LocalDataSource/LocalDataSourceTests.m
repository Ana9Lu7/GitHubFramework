//
//  LocalDataSourceTests.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <XCTest/XCTest.h>
#import "LocalDataSource.h"
#import "GithubRepositoryModel.h"
#import "GitTagModel.h"
#import "MockBaseLocalDataSource.h"

@interface LocalDataSourceTests : XCTestCase

@property (nonatomic, strong) LocalDataSource *localDataSource;
@property (nonatomic, strong) MockBaseLocalDataSource *mockBaseLocalDataSource;

@end

@implementation LocalDataSourceTests

- (void)setUp {
    [super setUp];
    self.mockBaseLocalDataSource = [[MockBaseLocalDataSource alloc] init];
    self.localDataSource = [[LocalDataSource alloc] initWithBaseLocalDataSource:self.mockBaseLocalDataSource];
    
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

// MARK: saveUserRepositories test

- (void)test_saveUserRepositories_nilRepository {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    [self.localDataSource saveUserRepositories:nil forKey:@"testUser"];

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);
    XCTAssertNil(self.mockBaseLocalDataSource.savedData);
}

- (void)test_saveUserRepositories_validRepository {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    NSDictionary *validRepoDict = @{@"name": @"TestRepo", @"tags_url": @"https://example.com/tags"};
    GitHubRepositoryModel *validRepo = [[GitHubRepositoryModel alloc] initWithDictionary:validRepoDict];
    [self.localDataSource saveUserRepositories:@[validRepo] forKey:@"testUser"];

    NSArray *retrievedRepos = [self.mockBaseLocalDataSource getDataForKey:@"testUser" allowedClasses:[NSSet setWithObjects:[NSArray class], [GitHubRepositoryModel class], nil]];

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);

    XCTAssertNotNil(retrievedRepos);
    XCTAssertEqual(retrievedRepos.count, 1);
    
    GitHubRepositoryModel *firstRetrievedRepo = retrievedRepos[0];
    XCTAssertEqualObjects(firstRetrievedRepo.name, @"TestRepo");
    XCTAssertEqualObjects(firstRetrievedRepo.tagsURL, @"https://example.com/tags");
}

- (void)test_saveUserRepositories_emptyRepository {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    NSDictionary *emptyRepoDict = @{};
    GitHubRepositoryModel *emptyRepo = [[GitHubRepositoryModel alloc] initWithDictionary:emptyRepoDict];
    [self.localDataSource saveUserRepositories:@[emptyRepo] forKey:@"testUser"];

    NSArray *retrievedRepos = [self.mockBaseLocalDataSource getDataForKey:@"testUser" allowedClasses:[NSSet setWithObjects:[NSArray class], [GitHubRepositoryModel class], nil]];

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);

    XCTAssertNotNil(retrievedRepos);
    XCTAssertEqual(retrievedRepos.count, 1);
    
    GitHubRepositoryModel *firstRetrievedRepo = retrievedRepos[0];
    XCTAssertNil(firstRetrievedRepo.name);
    XCTAssertNil(firstRetrievedRepo.tagsURL);
}

// MARK: getRepositoriesWitUsername test

- (void)test_getRepositoriesWitUsername_nilUser {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSArray *retrievedRepos = [self.localDataSource getRepositoriesWitUsername:nil];

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
    XCTAssertNil(retrievedRepos);
}

- (void)test_getRepositoriesWitUsername_userNotSaved {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSArray *retrievedRepos = [self.localDataSource getRepositoriesWitUsername:@"userNotSaved"];

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
    XCTAssertNil(retrievedRepos);
}

- (void)test_getRepositoriesWitUsername_validUser {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSDictionary *validRepoDict = @{@"name": @"TestGetRepo", @"tags_url": @"https://example.com/getRepo"};
    GitHubRepositoryModel *validRepo = [[GitHubRepositoryModel alloc] initWithDictionary:validRepoDict];
    [self.mockBaseLocalDataSource saveData:@[validRepo] forKey:@"testGetRepo"];
    
    NSArray *retrievedRepos = [self.localDataSource getRepositoriesWitUsername:@"testGetRepo"];
    XCTAssertNotNil(retrievedRepos);
    XCTAssertEqual(retrievedRepos.count, 1);

    GitHubRepositoryModel *firstRetrievedRepo = retrievedRepos[0];
    XCTAssertEqualObjects(firstRetrievedRepo.name, @"TestGetRepo");
    XCTAssertEqualObjects(firstRetrievedRepo.tagsURL, @"https://example.com/getRepo");

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

- (void)test_getRepositoriesWitUsername_empty {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSDictionary *emptyRepo = @{};
    GitHubRepositoryModel *validRepo = [[GitHubRepositoryModel alloc] initWithDictionary:emptyRepo];
    [self.mockBaseLocalDataSource saveData:@[validRepo] forKey:@"testGetRepo"];
    
    NSArray *retrievedRepos = [self.localDataSource getRepositoriesWitUsername:@"testGetRepo"];
    XCTAssertNotNil(retrievedRepos);
    XCTAssertEqual(retrievedRepos.count, 1);

    GitHubRepositoryModel *firstRetrievedRepo = retrievedRepos[0];
    XCTAssertNil(firstRetrievedRepo.name);
    XCTAssertNil(firstRetrievedRepo.tagsURL);

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

// MARK: saveRepositoryTags

- (void)test_saveRepositoryTags_nilTag {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    [self.localDataSource saveRepositoryTags:nil forKey:@"testSaveTag"];
    NSArray *retrievedTags = [self.localDataSource getRepositoryTags:@"testSaveTag"];
    XCTAssertNil(retrievedTags);

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);
}

- (void)test_saveRepositoryTags_validTagUrl {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    NSDictionary *validTagDict = @{@"name": @"v1.0"};
    GitTagModel *validTag = [[GitTagModel alloc] initWithDictionary:validTagDict];
    [self.localDataSource saveRepositoryTags:@[validTag] forKey:@"testSaveTag"];
    
    NSArray *retrievedTags = [self.mockBaseLocalDataSource getDataForKey:@"testSaveTag" allowedClasses:[NSSet setWithObjects:[NSArray class], [GitTagModel class], nil]];
    XCTAssertNotNil(retrievedTags);
    XCTAssertEqual(retrievedTags.count, 1);
    XCTAssertEqualObjects(((GitTagModel *)retrievedTags[0]).name, @"v1.0");

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);
}

- (void)test_saveRepositoryTags_emptyTags {
    XCTAssertFalse(self.mockBaseLocalDataSource.saveDataCalled);

    NSDictionary *emptyTagDict = @{};
    GitTagModel *emptyTag = [[GitTagModel alloc] initWithDictionary:emptyTagDict];
    [self.localDataSource saveRepositoryTags:@[emptyTag] forKey:@"testSaveTag"];
    
    NSArray *retrievedTags = [self.mockBaseLocalDataSource getDataForKey:@"testSaveTag" allowedClasses:[NSSet setWithObjects:[NSArray class], [GitTagModel class], nil]];
    XCTAssertNotNil(retrievedTags);
    XCTAssertEqual(retrievedTags.count, 1);
    XCTAssertNil(((GitTagModel *)retrievedTags[0]).name);

    XCTAssertTrue(self.mockBaseLocalDataSource.saveDataCalled);
}

// MARK: getRepositoryTags

- (void)test_getRepositoryTags_nilTagUrl {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSArray *retrievedTags = [self.localDataSource getRepositoryTags:nil];
    XCTAssertNil(retrievedTags);

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

- (void)test_getRepositoryTags_userNotSaved {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSArray *retrievedRepos = [self.localDataSource getRepositoriesWitUsername:@"repositoryTags"];
    XCTAssertNil(retrievedRepos);

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

- (void)test_getRepositoryTags_validTagUrl {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSDictionary *validTagDict = @{@"name": @"v1.0"};
    GitTagModel *validTag = [[GitTagModel alloc] initWithDictionary:validTagDict];
    [self.mockBaseLocalDataSource saveData:@[validTag] forKey:@"testTag"];
    
    NSArray *retrievedTags = [self.localDataSource getRepositoryTags:@"testTag"];
    XCTAssertNotNil(retrievedTags);
    XCTAssertEqual(retrievedTags.count, 1);
    XCTAssertEqualObjects(((GitTagModel *)retrievedTags[0]).name, @"v1.0");

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

- (void)test_getRepositoryTags_emptyTags {
    XCTAssertFalse(self.mockBaseLocalDataSource.getDataCalled);

    NSDictionary *emptyTagDict = @{};
    GitTagModel *emptyTag = [[GitTagModel alloc] initWithDictionary:emptyTagDict];
    [self.mockBaseLocalDataSource saveData:@[emptyTag] forKey:@"testTag"];
    
    NSArray *retrievedTags = [self.localDataSource getRepositoryTags:@"testTag"];
    XCTAssertNotNil(retrievedTags);
    XCTAssertEqual(retrievedTags.count, 1);
    XCTAssertNil(((GitTagModel *)retrievedTags[0]).name);

    XCTAssertTrue(self.mockBaseLocalDataSource.getDataCalled);
}

@end
