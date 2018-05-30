//
//  BSTPhotosCollectionViewController.h
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTMarsRover;
@class BSTSolDescription;

@interface BSTPhotosCollectionViewController : UICollectionViewController

@property (nonatomic, strong) BSTMarsRover *rover;
@property (nonatomic, strong) BSTSolDescription *sol;

@end
