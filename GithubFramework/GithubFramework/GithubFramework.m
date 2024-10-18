//
//  GithubFramework.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "GithubFramework.h"
#import "RemoteDataSource.h"
#import "LocalDataSource.h"

@implementation GithubFramework

+ (instancetype)sharedManager {
    static GithubFramework *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)fetchRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *repositories, NSError *error))completion {
    RemoteDataSource *repoManager = [RemoteDataSource sharedManager];
    LocalDataSource *localDataSource = [LocalDataSource sharedManager];
    
    [repoManager getRepositoriesForUser:username completion:^(NSArray *repositories, NSError *error) {
        if (error) {
            NSLog(@"Error fetching repositories from remote: %@", error.localizedDescription);
            NSArray *cachedRepositories = [localDataSource getRepositoriesWitUsername:[NSString stringWithFormat:@"%@_repositories", username]];
            if (cachedRepositories) {
                NSLog(@"Returning cached repositories for user %@", username);
                completion(cachedRepositories, nil);
            } else {
                NSLog(@"No cached repositories found for user %@", username);
                completion(nil, error);
            }
        } else {
//            [localDataSource saveUserRepositories:repositories forKey:[NSString stringWithFormat:@"%@_repositories", username]];
            completion(repositories, nil);
        }
    }];
}

- (void)fetchRepositoriesTag:(NSString *)tagsURL completion:(void (^)(NSArray *tags, NSError *error))completion {
    RemoteDataSource *repoManager = [RemoteDataSource sharedManager];
    
    [repoManager getTagsForRepository:tagsURL completion:^(NSArray *tags, NSError *error) {
        if (error) {
            NSLog(@"Error fetching repositories from remote: %@", error.localizedDescription);
        } else {
            completion(tags, nil);
        }
    }];
    
}


@end
