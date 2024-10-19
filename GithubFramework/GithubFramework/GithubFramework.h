//
//  GithubFramework.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>
#import <GithubFramework/GitTagModel.h>
#import <GithubFramework/GitHubRepositoryModel.h>

//! Project version number for GithubFramework.
FOUNDATION_EXPORT double GithubFrameworkVersionNumber;

//! Project version string for GithubFramework.
FOUNDATION_EXPORT const unsigned char GithubFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GithubFramework/PublicHeader.h>

@interface GithubFramework : NSObject

+ (instancetype)sharedManager;

- (void)fetchRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *repositories, NSError *error))completion;

- (void)fetchRepositoriesTag:(NSString *)tagsURL completion:(void (^)(NSArray *tags, NSError *error))completion;

- (void)setRemoteDataSource:(id)remoteDataSource localDataSource:(id)localDataSource;

@end
