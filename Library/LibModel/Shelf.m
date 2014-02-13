//
//  Shelf.m
//  Challenge1
//
//  Created by Larry on 2/9/14.
//  Copyright (c) 2014 Larry. All rights reserved.
//

#import "Shelf.h"

@implementation Shelf

- (id)init
{
    self = [super init];
    if (self)
    {
        self.books = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
