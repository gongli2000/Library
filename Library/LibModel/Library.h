//
//  Library.h
//  Challenge1
//
//  Created by Larry on 2/9/14.
//  Copyright (c) 2014 Larry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shelf.h"

@interface Library : NSObject

@property NSMutableArray *shelves;
@property NSString* name;

-(void) addShelves: (int) numshelves;
-(void) removeshelf:(Shelf*) shelf;
-(Shelf*) getshelf: (int) numshelf;
-(NSMutableArray*) getBooks;

@end
