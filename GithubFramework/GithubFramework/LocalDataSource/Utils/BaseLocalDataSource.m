//
//  BaseLocalDataSource.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "BaseLocalDataSource.h"

@implementation BaseLocalDataSource

+ (instancetype)sharedManager {
    static BaseLocalDataSource *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)saveData:(NSArray *)data forKey:(NSString *)key {
    NSError *error = nil;
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"Error archiving data: %@", error.localizedDescription);
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)getDataForKey:(NSString *)key allowedClasses:(NSSet *)allowedClasses {
    NSData *encodedData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (encodedData) {
        NSError *error = nil;
        NSArray *data = [NSKeyedUnarchiver unarchivedObjectOfClasses:allowedClasses fromData:encodedData error:&error];
        if (error) {
            NSLog(@"Error unarchiving data: %@", error.localizedDescription);
            return nil;
        }
        return data;
    }
    return nil;
}

@end
