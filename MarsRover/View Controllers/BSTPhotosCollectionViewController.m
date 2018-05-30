//
//  BSTPhotosCollectionViewController.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTPhotosCollectionViewController.h"
#import "BSTSolDescription.h"
#import "BSTMarsRoverClient.h"
#import "BSTMarsPhoto.h"
#import "BSTPhotoCollectionViewCell.h"
#import "BSTPhotoCache.h"
#import "MarsRover-Swift.h"

@interface BSTPhotosCollectionViewController ()

@property (nonatomic, strong, readonly) BSTMarsRoverClient *client;
@property (nonatomic, copy) NSArray *photoReferences;

@end

@implementation BSTPhotosCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchPhotoReferences];
}

#pragma mark - Private

- (void)fetchPhotoReferences
{
    if (!self.rover || !self.sol) {
        return;
    }
    
    BSTMarsRoverClient *client = [[BSTMarsRoverClient alloc] init];
    [client fetchPhotosFromRover:self.rover onSol:self.sol.sol completion:^(NSArray *photos, NSError *error) {
        if (error) {
            NSLog(@"Error getting photo references for %@ on %@: %@", self.rover, self.sol, error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoReferences = photos;
        });
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoReferences.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSTPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BSTMarsPhoto *photo = self.photoReferences[indexPath.row];
    
    BSTPhotoCache *cache = [BSTPhotoCache sharedCache];
    NSData *cachedData = [cache imageDataForIdentifier:photo.identifier];
    if (cachedData) {
        cell.imageView.image = [UIImage imageWithData:cachedData];
        return cell;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
    }
    
    [self.client fetchImageDataForPhoto:photo completion:^(NSData *imageData, NSError *error) {
        if (error || !imageData) {
            NSLog(@"Error fetching image data for %@: %@", photo, error);
            return;
        }
        
        [cache cacheImageData:imageData forIdentifier:photo.identifier];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![indexPath isEqual:[collectionView indexPathForCell:cell]]) {
                return; // Cell has been reused for another photo
            }
            cell.imageView.image = image;
        });
    }];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        PhotoDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        detailVC.photo = self.photoReferences[indexPath.row];
    }
}

#pragma mark - Properties

@synthesize client = _client;
- (BSTMarsRoverClient *)client
{
    if (!_client) {
        _client = [[BSTMarsRoverClient alloc] init];
    }
    return _client;
}

- (void)setRover:(BSTMarsRover *)rover
{
    if (rover != _rover) {
        _rover = rover;
        [self fetchPhotoReferences];
    }
}

- (void)setSol:(BSTSolDescription *)sol
{
    if (sol != _sol) {
        _sol = sol;
        [self fetchPhotoReferences];
    }
}

- (void)setPhotoReferences:(NSArray *)photoReferences
{
    if (photoReferences != _photoReferences) {
        _photoReferences = [photoReferences copy];
        [self.collectionView reloadData];
    }
}

@end
