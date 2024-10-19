//
//  GitHubRepositoryModel.m
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import "GitHubRepositoryModel.h"

@interface GitHubRepositoryModel () <NSSecureCoding>

@end

@implementation GitHubRepositoryModel

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _tagsURL = dictionary[@"tags_url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.tagsURL forKey:@"tags_url"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _tagsURL = [coder decodeObjectOfClass:[NSString class] forKey:@"tags_url"];
    }
    return self;
}

@end

