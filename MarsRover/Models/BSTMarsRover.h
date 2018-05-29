//
//  BSTMarsRover.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BSTMarsRoverStatus) {
    BSTMarsRoverStatusActive,
    BSTMarsRoverStatusComplete,
};

@interface DMNMarsRover : NSObject
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
    
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *launchDate;
@property (nonatomic, strong, readonly) NSDate *landingDate;
@property (nonatomic, readonly) BSTMarsRoverStatus status;
@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, strong, readonly) NSDate *maxDate;
@property (nonatomic, readonly) NSInteger numberOfPhotos;
@property (nonatomic, strong, readonly) NSArray *solDescriptions;
    
@end
