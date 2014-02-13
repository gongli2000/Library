//
//  Book.h
//  Challenge1
//
//  Created by Larry on 2/9/14.
//  Copyright (c) 2014 Larry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Library.h"
#import "Shelf.h"

@interface Book : NSObject

@property NSString *title;
@property NSString *author;
@property NSString *publisher;

- (id)init: (NSString*) title  author:(NSString* )author;

-(void) enshelf: (Shelf*) shelf;
-(void) unshelf: (Shelf *) shelf ;
@end
