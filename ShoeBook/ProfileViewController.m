//
//  ProfileViewController.m
//  ShoeBook
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ProfileViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Comment.h"
#import "Shoe.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"UserCache"];
    [self.fetchedResultsController performFetch:nil];

    self.fetchedResultsController.delegate = self;

    if (!self.fetchedResultsController.fetchedObjects.count) {
        [self loadFriends];
    }
}

- (void)loadFriends
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/4/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *users = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        for (NSString *user in users) {
            NSManagedObject *friendObject = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
            [friendObject setValue:user forKeyPath:@"name"];
        }
        [self.managedObjectContext save:nil];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];

    cell.textLabel.text = user.name;

    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.profileTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *destinationVC = segue.destinationViewController;
    destinationVC.fetchedResultsController = self.fetchedResultsController;
    destinationVC.managedObjectContext = self.managedObjectContext;
    User *user = [self.fetchedResultsController objectAtIndexPath:self.profileTableView.indexPathForSelectedRow];
    destinationVC.detailItem = user;
    destinationVC.title = user.name;
}

@end
