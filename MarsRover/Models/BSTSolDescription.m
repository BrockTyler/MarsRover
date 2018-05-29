//
//  BSTSolDescription.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTSolDescription.h"

@implementation BSTSolDescription
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _sol = [dictionary[@"sol"] integerValue];
        _numberOfPhotos = [dictionary[@"total_photos"] integerValue];
        _cameras = [dictionary[@"cameras"] copy];
    }
    return self;
}

@end
