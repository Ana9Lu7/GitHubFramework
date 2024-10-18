//
//  Tag.m
//  gitFramework
//
//  Created by Ana Luiza on 17/10/24.
//

#import "GitTagModel.h"

@implementation GitTagModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
    }
    return self;
}

@end
