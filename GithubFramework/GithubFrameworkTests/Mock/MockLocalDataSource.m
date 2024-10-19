//
//  MockLocalDataSource.m
//  GithubFrameworkTests
//
//  Created by Ana Luiza on 18/10/24.
//

#import "LocalDataSource.h"
#import "GithubRepositoryModel.h"
#import "GitTagModel.h"

@interface MockLocalDataSource : LocalDataSource

@property (nonatomic, strong) NSMutableDictionary *mockDataStore;
@property (nonatomic, strong) NSArray<GitHubRepositoryModel *> *mockRepositories;
@property (nonatomic, strong) NSArray<GitTagModel *> *mockTags;

@end

@implementation MockLocalDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _mockDataStore = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)saveUserRepositories:(NSArray<GitHubRepositoryModel *> *)data forKey:(NSString *)key {
    if (data) {
        self.mockDataStore[key] = data;
    }
}

- (NSArray<GitHubRepositoryModel *> *)getRepositoriesWitUsername:(NSString *)username {
    return self.mockDataStore[username];
}

- (void)saveRepositoryTags:(NSArray<GitTagModel *> *)data forKey:(NSString *)key {
    if (data) {
        self.mockDataStore[key] = data;
    }
}

- (NSArray<GitTagModel *> *)getRepositoryTags:(NSString *)tagUrl {
    return self.mockDataStore[tagUrl];
}

@end
