//
//  GitTagModel.h
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GitTagModel : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
