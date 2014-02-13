//
//  Library.m
//  Challenge1
//
//  Created by Larry on 2/9/14.
//  Copyright (c) 2014 Larry. All rights reserved.
//
#import "Shelf.h"
#import "Library.h"

@implementation Library


- (id)init
{
    self = [super init];
    if (self)
    {
        self.shelves = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addShelves: (int) numshelves
{
    for(int i =0;i < numshelves ;i++){
     Shelf* shelf = [[Shelf alloc] init];
     [self.shelves addObject: shelf];
    }
}

-(void) removeshelf:(Shelf*) shelf{
    [self.shelves removeObject: shelf];
}

-(Shelf*) getshelf:(int) numshelf{
    return self.shelves[numshelf];
}

-(NSMutableArray*) getBooks{
    NSMutableArray *books = [[NSMutableArray alloc] init];
    for(int i=0;i < self.shelves.count; i++){
        Shelf* shelf = self.shelves[i];
        [books addObjectsFromArray: [shelf.books allValues]];
    }
    return books;
}
@end
