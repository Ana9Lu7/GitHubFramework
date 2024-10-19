//
//  GithubFramework.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "GithubFramework.h"
#import "RemoteDataSource.h"
#import "LocalDataSource.h"

@interface GithubFramework ()

@property (nonatomic, strong) id remoteDataSource;
@property (nonatomic, strong) id localDataSource;

@end

@implementation GithubFramework

+ (instancetype)sharedManager {
    static GithubFramework *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.remoteDataSource = [RemoteDataSource sharedManager];
        sharedInstance.localDataSource = [LocalDataSource sharedManager];
    });
    return sharedInstance;
}

- (void)setRemoteDataSource:(id)remoteDataSource localDataSource:(id)localDataSource {
    self.remoteDataSource = remoteDataSource;
    self.localDataSource = localDataSource;
}

- (void)fetchRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *repositories, NSError *error))completion {
    if (!self.remoteDataSource) {
        NSLog(@"Remote data source not set.");
        return;
    }
    if (!self.localDataSource) {
        NSLog(@"Local data source not set.");
        return;
    }

    [self.remoteDataSource getRepositoriesForUser:username completion:^(NSArray *repositories, NSError *error) {
        if (error) {
            NSLog(@"Error fetching repositories from remote: %@", error.localizedDescription);
            NSArray *cachedRepositories = [self.localDataSource getRepositoriesWitUsername:[NSString stringWithFormat:@"%@", username]];
            if (cachedRepositories) {
                NSLog(@"Returning cached repositories for user %@", username);
                completion(cachedRepositories, nil);
            } else {
                NSLog(@"No cached repositories found for user %@", username);
                completion(nil, error);
            }
        } else {
            [self.localDataSource saveUserRepositories:repositories forKey:[NSString stringWithFormat:@"%@", username]];
            completion(repositories, nil);
        }
    }];
}

- (void)fetchRepositoriesTag:(NSString *)tagsURL completion:(void (^)(NSArray *tags, NSError *error))completion {
    if (!self.remoteDataSource) {
        NSLog(@"Remote data source not set.");
        return;
    }
    if (!self.localDataSource) {
        NSLog(@"Local data source not set.");
        return;
    }

    [self.remoteDataSource getTagsForRepository:tagsURL completion:^(NSArray *tags, NSError *error) {
        if (error) {
            NSLog(@"Error fetching repositories from remote: %@", error.localizedDescription);
            NSArray *cachedTags = [self.localDataSource getRepositoryTags:[NSString stringWithFormat:@"%@", tagsURL]];
            if (cachedTags) {
                NSLog(@"Returning cached tags for repository %@", tagsURL);
                completion(cachedTags, nil);
            } else {
                NSLog(@"No cached tags found for repository %@", tagsURL);
                completion(nil, error);
            }
        } else {
            [self.localDataSource saveRepositoryTags:tags forKey:[NSString stringWithFormat:@"%@", tagsURL]];
            completion(tags, nil);
        }
    }];
}

@end
