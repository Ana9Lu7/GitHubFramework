//
//  GitTagModel.m
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import "GitTagModel.h"

@interface GitTagModel () <NSSecureCoding>

@end

@implementation GitTagModel

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
    }
    return self;
}

@end

