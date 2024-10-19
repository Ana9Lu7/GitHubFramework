//
//  MockBaseLocalDataSource.h
//  GithubFramework
//
//  Created by Ana Luiza on 18/10/24.
//

#import "BaseLocalDataSource.h"

@interface MockBaseLocalDataSource : BaseLocalDataSource

@property (nonatomic, assign) BOOL saveDataCalled;
@property (nonatomic, strong) id savedData;
@property (nonatomic, assign) BOOL getDataCalled;
@property (nonatomic, strong) NSMutableDictionary *dataStore;

@end
