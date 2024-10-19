//
//  BaseLocalDataSource.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import <Foundation/Foundation.h>

/// A base class for managing local data storage and retrieval. This class provides methods to save and fetch data using a key.
@interface BaseLocalDataSource : NSObject

+ (instancetype)sharedManager;

- (void)saveData:(NSArray *)data forKey:(NSString *)key;
- (NSArray *)getDataForKey:(NSString *)key allowedClasses:(NSSet *)allowedClasses;

@end
