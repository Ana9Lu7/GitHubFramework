//
//  LocalDataSource.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "LocalDataSource.h"

@implementation LocalDataSource

- (instancetype)initWithBaseLocalDataSource:(BaseLocalDataSource *)baseLocalDataSource {
    self = [super init];
    if (self) {
        _baseLocalDataSource = baseLocalDataSource;
    }
    return self;
}

+ (instancetype)sharedManager {
    static LocalDataSource *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initWithBaseLocalDataSource:[BaseLocalDataSource sharedManager]];
    });
    return sharedManager;
}

- (void)saveUserRepositories:(NSArray<GitHubRepositoryModel *> *)data forKey:(NSString *)key {
    [self.baseLocalDataSource saveData:data forKey:key];
}

- (NSArray<GitHubRepositoryModel *> *)getRepositoriesWitUsername:(NSString *)username {
    NSSet *allowedClasses = [NSSet setWithObjects:[NSArray class], [GitHubRepositoryModel class], nil];
    return [self.baseLocalDataSource getDataForKey:username allowedClasses:allowedClasses];
}

- (void)saveRepositoryTags:(NSArray<GitTagModel *> *)data forKey:(NSString *)key {
    [self.baseLocalDataSource saveData:data forKey:key];
}

- (NSArray<GitTagModel *> *)getRepositoryTags:(NSString *)tagUrl {
    NSSet *allowedClasses = [NSSet setWithObjects:[NSArray class], [GitTagModel class], nil];
    return [self.baseLocalDataSource getDataForKey:tagUrl allowedClasses:allowedClasses];
}

@end
