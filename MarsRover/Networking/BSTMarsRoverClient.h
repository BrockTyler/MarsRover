//
//  BSTMarsRoverClient.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSTMarsRover;
@class BSTMarsPhoto;

@interface BSTMarsRoverClient : NSObject
    
- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray *roverNames, NSError *error))completion;
    
- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(BSTMarsRover *rover, NSError *error))completion;
    
- (void)fetchPhotosFromRover:(BSTMarsRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray *photos, NSError *error))completion;
    
- (void)fetchImageDataForPhoto:(BSTMarsPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;
    
    @end
