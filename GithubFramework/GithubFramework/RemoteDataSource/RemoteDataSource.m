//
//  RemoteDataSource.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "RemoteDataSource.h"
#import "GitHubRepositoryModel.h"
#import "GitTagModel.h"

@interface RemoteDataSource ()

@property (nonatomic, strong) NetworkManager *networkManager;

@end

@implementation RemoteDataSource

- (instancetype)initWithNetworkManager:(NetworkManager *)networkManager {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
    }
    return self;
}

+ (instancetype)sharedManager {
    static RemoteDataSource *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initWithNetworkManager:[NetworkManager sharedManager]];
    });
    return sharedManager;
}

- (void)getRepositoriesForUser:(NSString *)username completion:(NetworkCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", username];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self.networkManager getRequestWithURL:url method:@"GET" modelClass:[GitHubRepositoryModel class] completion:completion];
}

- (void)getTagsForRepository:(NSString *)tagsURL completion:(NetworkCompletion)completion {
    NSURL *url = [NSURL URLWithString:tagsURL];
    
    [self.networkManager getRequestWithURL:url method:@"GET" modelClass:[GitTagModel class] completion:completion];
}

@end
