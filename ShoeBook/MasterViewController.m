#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ProfileViewController.h"
#import "Comment.h"
#import "Shoe.h"
#import "User.h"

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    request.predicate = predicate;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [self.fetchedResultsController performFetch:nil];


    self.fetchedResultsController.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.textLabel.text = user.name;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] name];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDetail"])
    {
        DetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.fetchedResultsController = self.fetchedResultsController;
        destinationVC.managedObjectContext = self.managedObjectContext;
        User *user = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        destinationVC.detailItem = user;
        destinationVC.title = user.name;
    }
    else {
        ProfileViewController *destinationVC = segue.destinationViewController;
        destinationVC.fetchedResultsController = self.fetchedResultsController;
        destinationVC.managedObjectContext = self.managedObjectContext;
    }
}


@end