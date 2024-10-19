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

/// A Framework to get GitHub repository information.
@interface GithubFramework : NSObject

+ (instancetype)sharedManager;

/// Fetches the repositories for a given GitHub user.
- (void)fetchRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *repositories, NSError *error))completion;

/// Fetches the tags for a given repository URL.
- (void)fetchRepositoriesTag:(NSString *)tagsURL completion:(void (^)(NSArray *tags, NSError *error))completion;

/// Sets the remote and local data sources for the data manager.
- (void)setRemoteDataSource:(id)remoteDataSource localDataSource:(id)localDataSource;

@end
