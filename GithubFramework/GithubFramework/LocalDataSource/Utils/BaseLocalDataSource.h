//
//  BaseLocalDataSource.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>

@interface BaseLocalDataSource : NSObject

+ (instancetype)sharedManager;

- (void)saveData:(NSArray *)data forKey:(NSString *)key;
- (NSArray *)getDataForKey:(NSString *)key allowedClasses:(NSSet *)allowedClasses;

@end
