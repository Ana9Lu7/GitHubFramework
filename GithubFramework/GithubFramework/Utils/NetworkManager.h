//
//  NetworkManager.h
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NetworkCompletion)(id _Nullable result, NSError * _Nullable error);

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)getRequestWithURL:(NSURL *)url method:(NSString *)method modelClass:(Class)modelClass completion:(NetworkCompletion)completion;

- (void)decodeData:(NSData *)data toModelClass:(Class)modelClass completion:(NetworkCompletion)completion;

@end

NS_ASSUME_NONNULL_END
