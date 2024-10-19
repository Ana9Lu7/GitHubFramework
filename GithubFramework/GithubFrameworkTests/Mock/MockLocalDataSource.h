//
//  MockLocalDataSource.h
//  GithubFramework
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

