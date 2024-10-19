//
//  MockNetworkManager.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@interface MockNetworkManager : NSObject

@property (nonatomic, strong) NSArray *mockRepositories;
@property (nonatomic, strong) NSArray *mockTags;
@property (nonatomic, strong) NSError *mockError;

- (void)getRequestWithURL:(NSURL *)url method:(NSString *)method modelClass:(Class)modelClass completion:(NetworkCompletion)completion;

@end
