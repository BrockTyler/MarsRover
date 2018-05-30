//
//  BSTRoversTableViewController.m
//  MarsRover
//
//  Created by brock tyler on 5/29/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

#import "BSTRoversTableViewController.h"
#import "BSTMarsRover.h"
#import "BSTMarsRoverClient.h"
#import "BSTSolsTableViewController.h"

@interface BSTRoversTableViewController ()

@property (nonatomic, copy) NSArray *rovers;

@end

@implementation BSTRoversTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *rovers = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    BSTMarsRoverClient *client = [[BSTMarsRoverClient alloc] init];
    [client fetchAllMarsRoversWithCompletion:^(NSArray *roverNames, NSError *error) {
        if (error) {
            NSLog(@"Error fetching list of mars rovers: %@", error);
            return;
        }
        
        dispatch_queue_t resultsQueue = dispatch_queue_create("com.devmountain.roverFetchResultsQueue", 0);
        
        for (NSString *name in roverNames) {
            dispatch_group_enter(group);
            [client fetchMissionManifestForRoverNamed:name completion:^(BSTMarsRover *rover, NSError *error) {
                if (error) {
                    NSLog(@"Error fetching list of mars rovers: %@", error);
                    dispatch_group_leave(group);
                    return;
                }
                
                dispatch_async(resultsQueue, ^{
                    [rovers addObject:rover];
                    dispatch_group_leave(group);
                });
            }];
        }
        
        dispatch_group_leave(group);
    }];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    self.rovers = rovers;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rovers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoverCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.rovers[indexPath.row] name];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowSolsSegue"]) {
        BSTSolsTableViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destinationVC.rover = self.rovers[indexPath.row];
    }
}

#pragma mark - Properties

- (void)setRovers:(NSArray *)rovers
{
    if (rovers != _rovers) {
        _rovers = [rovers copy];
        [self.tableView reloadData];
    }
}

@end
