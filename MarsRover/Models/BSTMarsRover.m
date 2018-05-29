//
//  BSTMarsRover.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTMarsRover.h"
#import "BSTSolDescription.h"

@implementation BSTMarsRover
    
+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    });
    return dateFormatter;
}
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        if (!_name) { return nil; }
        NSString *launchDateString = dictionary[@"launch_date"];
        _launchDate = [[[self class] dateFormatter] dateFromString:launchDateString];
        NSString *landingDateString = dictionary[@"landing_date"];
        _landingDate = [[[self class] dateFormatter] dateFromString:landingDateString];
        _status = [dictionary[@"status"] isEqualToString:@"active"] ? BSTMarsRoverStatusActive : BSTMarsRoverStatusComplete;
        _maxSol = [dictionary[@"max_sol"] integerValue];
        NSString *maxDateString = dictionary[@"max_date"];
        _maxDate = [[[self class] dateFormatter] dateFromString:maxDateString];
        _numberOfPhotos = [dictionary[@"total_photos"] integerValue];
            
        NSArray *solDescriptionDictionaries = dictionary[@"photos"];
        NSMutableArray *solDescriptions = [NSMutableArray array];
        for (NSDictionary *dict in solDescriptionDictionaries) {
            BSTSolDescription *solDescription = [[BSTSolDescription alloc] initWithDictionary:dict];
            if (!solDescription) { continue; }
            [solDescriptions addObject:solDescription];
        }
        _solDescriptions = [solDescriptions copy];
    }
    return self;
}
    
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@ photos", [super description], self.name, @(self.numberOfPhotos)];
}
    
@end
