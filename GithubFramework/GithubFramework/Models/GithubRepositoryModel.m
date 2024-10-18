//
//  GithubRepositoryModel.m
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import "GithubRepositoryModel.h"

@implementation GithubRepositoryModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _tagsURL = dictionary[@"tags_url"];
    }
    return self;
}

@end
