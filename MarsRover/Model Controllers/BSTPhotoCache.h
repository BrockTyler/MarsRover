//
//  BSTPhotoCache.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTPhotoCache : NSObject
    
@property (nonatomic, readonly, class) BSTPhotoCache *sharedCache;
    
- (void)cacheImageData:(NSData *)data forIdentifier:(NSInteger)identifier;
- (NSData *)imageDataForIdentifier:(NSInteger)identifier;
    
@end
