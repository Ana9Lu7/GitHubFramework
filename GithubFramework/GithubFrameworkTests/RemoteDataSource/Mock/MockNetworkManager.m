//
//  MockNetworkManager.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "MockNetworkManager.h"
#import "GitHubRepositoryModel.h"
#import "GitTagModel.h"

@implementation MockNetworkManager

- (void)getRequestWithURL:(NSURL *)url method:(NSString *)method modelClass:(Class)modelClass completion:(NetworkCompletion)completion {
    if (self.mockError) {
        completion(nil, self.mockError);
    } else if (modelClass == [GitHubRepositoryModel class]) {
        completion(self.mockRepositories, nil);
    } else if (modelClass == [GitTagModel class]) {
        completion(self.mockTags, nil);
    }
}

@end
