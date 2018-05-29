//
//  BSTPhotoCache.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTPhotoCache.h"

@interface BSTPhotoCache ()
    
@property (nonatomic, strong) NSCache *cache;
    
@end

@implementation BSTPhotoCache
    
+ (instancetype)sharedCache
{
    static BSTPhotoCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[self alloc] init];
    });
    return sharedCache;
}
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        _cache.name = @"com.DevMountain.MarsRover.PhotosCache";
    }
    return self;
}
    
- (void)cacheImageData:(NSData *)data forIdentifier:(NSInteger)identifier
{
    [self.cache setObject:data forKey:@(identifier) cost:[data length]];
}
    
- (NSData *)imageDataForIdentifier:(NSInteger)identifier
{
    return [self.cache objectForKey:@(identifier)];
}
    
@end
