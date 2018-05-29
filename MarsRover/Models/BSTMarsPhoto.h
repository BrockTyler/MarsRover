//
//  BSTMarsPhoto.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTMarsPhoto : NSObject
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
    
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, strong, readonly) NSString *cameraName;
@property (nonatomic, strong, readonly) NSDate *earthDate;
@property (nonatomic, strong, readonly) NSURL *imageURL;
    
@end
