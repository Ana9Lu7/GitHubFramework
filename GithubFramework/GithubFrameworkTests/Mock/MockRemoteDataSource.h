//
//  MockRemoteDataSource.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//


#import <Foundation/Foundation.h>

@interface MockRemoteDataSource : NSObject

@property (nonatomic, strong) NSArray *mockRepositories;
@property (nonatomic, strong) NSArray *mockTags;
@property (nonatomic, strong) NSError *mockError;

- (void)getRepositoriesForUser:(NSString *)username completion:(void (^)(NSArray *repositories, NSError *error))completion;
- (void)getTagsForRepository:(NSString *)tagsURL completion:(void (^)(NSArray *tags, NSError *error))completion;

@end

