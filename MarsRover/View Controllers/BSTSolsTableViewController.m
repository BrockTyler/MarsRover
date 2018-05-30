//
//  BSTSolsTableViewController.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTSolsTableViewController.h"
#import "BSTMarsRover.h"
#import "BSTSolDescription.h"
#import "BSTPhotosCollectionViewController.h"

@interface BSTSolsTableViewController ()

@end

@implementation BSTSolsTableViewController

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rover.solDescriptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SolCell" forIndexPath:indexPath];
    
    BSTSolDescription *sol = self.rover.solDescriptions[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Sol %@", @(sol.sol)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos", @(sol.numberOfPhotos)];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPhotosSegue"]) {
        BSTPhotosCollectionViewController *destVC = segue.destinationViewController;
        destVC.rover = self.rover;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destVC.sol = self.rover.solDescriptions[indexPath.row];
    }
}


#pragma mark - Properties

- (void)setRover:(BSTMarsRover *)rover
{
    if (rover != _rover) {
        _rover = rover;
        [self.tableView reloadData];
    }
}

@end
