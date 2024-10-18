//
//  NetworkManager.m
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)getRequestWithURL:(NSURL *)url method:(NSString *)method modelClass:(Class)modelClass completion:(NetworkCompletion)completion {
    NSLog(@"Request URL: %@", url.absoluteString);
    NSLog(@"HTTP Method: %@", method);
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Network error: %@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if (data) {
            if (response) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSLog(@"StatusCode: %ld", (long)httpResponse.statusCode);
                NSLog(@"API Response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            }
            [self decodeData:data toModelClass:modelClass completion:completion];
        } else {
            NSError *dataError = [NSError errorWithDomain:@"NetworkErrorDomain" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"Data not found"}];
            completion(nil, dataError);
        }
    }];
    
    [dataTask resume];
}

- (void)decodeData:(NSData *)data toModelClass:(Class)modelClass completion:(NetworkCompletion)completion {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    if (error) {
        completion(nil, error);
        return;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dict in (NSArray *)jsonObject) {
            if ([modelClass instancesRespondToSelector:@selector(initWithDictionary:)]) {
                id model = [[modelClass alloc] initWithDictionary:dict];
                if (model) {
                    [modelsArray addObject:model];
                }
            }
        }
        completion(modelsArray, nil);
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        if ([modelClass respondsToSelector:@selector(initWithDictionary:)]) {
            id model = [[modelClass alloc] initWithDictionary:jsonObject];
            completion(model, nil);
        }
    } else {
        NSError *typeError = [NSError errorWithDomain:@"NetworkErrorDomain" code:1002 userInfo:@{NSLocalizedDescriptionKey: @"Invalid JSON format"}];
        completion(nil, typeError);
    }
}

@end
