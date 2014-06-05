//
//  Comment.h
//  ShoeBook
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shoe, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) User *users;
@property (nonatomic, retain) NSSet *shoes;
@end

@interface Comment (CoreDataGeneratedAccessors)

- (void)addShoesObject:(Shoe *)value;
- (void)removeShoesObject:(Shoe *)value;
- (void)addShoes:(NSSet *)values;
- (void)removeShoes:(NSSet *)values;

@end
