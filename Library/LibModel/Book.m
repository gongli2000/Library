//
//  Book.m
//  Challenge1
//
//  Created by Larry on 2/9/14.
//  Copyright (c) 2014 Larry. All rights reserved.
//

#import "Book.h"


@implementation Book

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title= @"";
        self.author=@"";
    }
    return self;
}

- (id)init: (NSString*) title  author:(NSString* )author
{
    self = [super init];
    if (self)
    {
        self.title= title;
        self.author=author;
    }
    return self;
}

-(void) enshelf: (Shelf*) shelf
{
    [shelf.books setValue:self forKey: self.title];
    
}

-(void) unshelf: (Shelf *) shelf
{
    [shelf.books removeObjectForKey: self.title];
}

@end
