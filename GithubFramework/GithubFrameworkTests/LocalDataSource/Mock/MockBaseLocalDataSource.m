//
//  MockBaseLocalDataSource.m
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "MockBaseLocalDataSource.h"

@implementation MockBaseLocalDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataStore = [NSMutableDictionary dictionary];
        _saveDataCalled = NO;
        _getDataCalled = NO;
    }
    return self;
}

- (void)saveData:(id)data forKey:(NSString *)key {
    self.saveDataCalled = YES;
    self.savedData = data;
    self.dataStore[key] = data;
}

- (id)getDataForKey:(NSString *)key allowedClasses:(NSSet *)allowedClasses {
    self.getDataCalled = YES;
    return self.dataStore[key];
}

@end
