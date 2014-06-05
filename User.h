//
//  User.h
//  ShoeBook
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Shoe;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * shoeSize;
@property (nonatomic, retain) NSString * favoriteShoe;
@property (nonatomic, retain) NSString * favoriteColor;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSSet *shoes;
@property (nonatomic, retain) NSSet *comments;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addShoesObject:(Shoe *)value;
- (void)removeShoesObject:(Shoe *)value;
- (void)addShoes:(NSSet *)values;
- (void)removeShoes:(NSSet *)values;

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
