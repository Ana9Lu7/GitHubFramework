//
//  RemoteDataSource.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "RemoteDataSource.h"
#import "GithubRepositoryModel.h"
#import "GitTagModel.h"

@implementation RemoteDataSource

+ (instancetype)sharedManager {
    static RemoteDataSource *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)getRepositoriesForUser:(NSString *)username completion:(NetworkCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", username];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NetworkManager sharedManager] getRequestWithURL:url method:@"GET" modelClass:[GithubRepositoryModel class] completion:completion];
}

- (void)getTagsForRepository:(NSString *)tagsURL completion:(NetworkCompletion)completion {
    NSURL *url = [NSURL URLWithString:tagsURL];
    
    [[NetworkManager sharedManager] getRequestWithURL:url method:@"GET" modelClass:[GitTagModel class] completion:completion];
}

@end
