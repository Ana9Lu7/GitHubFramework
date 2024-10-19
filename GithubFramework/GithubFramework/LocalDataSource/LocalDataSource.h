//
//  LocalDataSource.h
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "BaseLocalDataSource.h"
#import "GithubRepositoryModel.h"
#import "GitTagModel.h"

@interface LocalDataSource : NSObject

@property (nonatomic, strong) BaseLocalDataSource *baseLocalDataSource;

+ (instancetype)sharedManager;

- (instancetype)initWithBaseLocalDataSource:(BaseLocalDataSource *)baseLocalDataSource;

- (void)saveUserRepositories:(NSArray<GitHubRepositoryModel *> *)data forKey:(NSString *)key;
- (NSArray<GitHubRepositoryModel *> *)getRepositoriesWitUsername:(NSString *)username;

- (void)saveRepositoryTags:(NSArray<GitTagModel *> *)data forKey:(NSString *)key;
- (NSArray<GitTagModel *> *)getRepositoryTags:(NSString *)tagUrl;

@end

