//
//  BSTSolDescription.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTSolDescription : NSObject
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
    
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, readonly) NSInteger numberOfPhotos;
@property (nonatomic, strong, readonly) NSArray *cameras;
    
@end
