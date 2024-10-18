//
//  RemoteDataSource.h
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@interface RemoteDataSource : NSObject

+ (instancetype)sharedManager;

- (void)getRepositoriesForUser:(NSString *)username completion:(NetworkCompletion)completion;

- (void)getTagsForRepository:(NSString *)tagsURL completion:(NetworkCompletion)completion;

@end
