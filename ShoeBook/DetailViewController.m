//
//  DetailViewController.m
//  ShoeBook
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ProfileViewController.h"
#import "Comment.h"
#import "Shoe.h"
#import "User.h"
#import "ShoeCollectionViewCell.h"

@interface DetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *picturesCollectionView;
@property NSMutableArray *chosenImages;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.chosenImages = [[NSMutableArray alloc] init];

    self.colorLabel.text = [self.detailItem valueForKey:@"favoriteColor"];
    self.brandLabel.text = [self.detailItem valueForKey:@"favoriteShoe"];
    if ([[self.detailItem valueForKey:@"shoeSize"] integerValue] > 0) {
        self.sizeLabel.text = [NSString stringWithFormat:@"%@",[self.detailItem valueForKey:@"shoeSize"]];
    }
}

- (IBAction)onFavoriteButtonPressed:(UIBarButtonItem *)sender
{
    User *updatedUser = self.detailItem;
    updatedUser.favorite = [NSNumber numberWithBool:YES];
    [self.managedObjectContext save:nil];
}

- (IBAction)onCameraButtonPressed:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)onAddComment:(UITextField *)sender
{
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
    comment.comment = sender.text;
    [self.managedObjectContext save:nil];
    [sender resignFirstResponder];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.chosenImages addObject:chosenImage];
    [self.picturesCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // User *user = self.detailItem;
    return self.chosenImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShoeCell" forIndexPath:indexPath];
    //User *user = self.detailItem;
    cell.imageView.image = [self.chosenImages objectAtIndex:indexPath.row];
    return cell;
}

@end
