//
//  LocalDataSource.m
//  gitFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "LocalDataSource.h"

@implementation LocalDataSource

+ (instancetype)sharedManager {
    static LocalDataSource *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)saveUserRepositories:(NSArray *)data forKey:(NSString *)key {
    NSError *error = nil;
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:NO error:&error];
    
    if (error) {
        NSLog(@"Error archiving data: %@", error.localizedDescription);
        return;
    }

    [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)getRepositoriesWitUsername:(NSString *)username {
    NSData *encodedData = [[NSUserDefaults standardUserDefaults] objectForKey:username];
    if (encodedData) {
        NSError *error = nil;
        NSArray *data = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:encodedData error:&error];
        if (error) {
            NSLog(@"Error unarchiving data: %@", error.localizedDescription);
            return nil;
        }
        return data;
    }
    return nil;
}

@end
