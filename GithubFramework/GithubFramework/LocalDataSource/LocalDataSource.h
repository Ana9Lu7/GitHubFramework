//
//  LocalDataSource.h
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>

@interface LocalDataSource : NSObject

+ (instancetype)sharedManager;

- (void)saveUserRepositories:(NSArray *)data forKey:(NSString *)key;

- (NSArray *)getRepositoriesWitUsername:(NSString *)key;

@end
