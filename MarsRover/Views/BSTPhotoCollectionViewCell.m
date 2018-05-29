//
//  BSTPhotoCollectionViewCell.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTPhotoCollectionViewCell.h"

@implementation BSTPhotoCollectionViewCell
    
- (void)prepareForReuse
{
    [super prepareForReuse];
        
    self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}
    
@end

