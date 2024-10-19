//
//  RemoteDataSource.h
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

/// A class responsible for fetching data from a remote source. This class utilizes the NetworkManager to perform network requests for repositories and tags associated with a GitHub user.
@interface RemoteDataSource : NSObject

- (instancetype)initWithNetworkManager:(NetworkManager *)networkManager;

+ (instancetype)sharedManager;

- (void)getRepositoriesForUser:(NSString *)username completion:(NetworkCompletion)completion;

- (void)getTagsForRepository:(NSString *)tagsURL completion:(NetworkCompletion)completion;

@end
