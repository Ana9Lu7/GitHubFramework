//
//  MockRemoteDataSource.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "MockRemoteDataSource.h"

@implementation MockRemoteDataSource

- (void)getRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *, NSError *))completion {
    if (self.mockError) {
        completion(nil, self.mockError);
    } else {
        completion(self.mockRepositories, nil);
    }
}

- (void)getTagsForRepository:(NSString *)tagsURL completion:(void (^)(NSArray *, NSError *))completion {
    if (self.mockError) {
        completion(nil, self.mockError);
    } else {
        completion(self.mockTags, nil);
    }
}

@end
