//
//  MTBooksViewController.m
//  Library
//
//  Created by Bart Jacobs on 19/12/12.
//  Copyright (c) 2012 Mobile Tuts. All rights reserved.
//

#import "ShelvesTableViewController.h"


@interface ShelvesTableViewController ()

@property NSArray *shelves;

@end

@implementation ShelvesTableViewController

#pragma mark -
#pragma mark Initialization
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"Shelves";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Getters and Setters
- (void)setCurrentShelf:(NSString *)shelf {
    if (_currentShelf != shelf) {
        _currentShelf = shelf;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
        NSArray *authors = [NSArray arrayWithContentsOfFile:filePath];
        
        for (int i = 0; i < [authors count]; i++) {
            NSDictionary *authorDictionary = [authors objectAtIndex:i];
            NSString *tempAuthor = [authorDictionary objectForKey:@"Library"];
            
            if ([tempAuthor isEqualToString:_currentShelf]) {
                self.shelves = [authorDictionary objectForKey:@"Shelves"];
            }
        }
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shelves count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch Books
    NSDictionary *shelf = [self.shelves objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:[shelf objectForKey:@"Title"]];
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Initialize Book Cover View Controller
//    BooksTableViewController *bookCoverViewController = [[BooksTableViewController alloc] initWithNibName:@"MTBookCoverViewController" bundle:[NSBundle mainBundle]];
//    
//    // Fetch and Set Book Cover
//    NSDictionary *book = [self.books objectAtIndex:[indexPath row]];
//    UIImage *bookCover = [UIImage imageNamed:[book objectForKey:@"Cover"]];
//    [bookCoverViewController setBookCover:bookCover];
//    
//    // Push View Controller onto Navigation Stack
//    [self.navigationController pushViewController:bookCoverViewController animated:YES];
    
    // Initialize Books View Controller
    ShelvesTableViewController *booksViewController = [[ShelvesTableViewController alloc] init];
    
    // Fetch and Set books
    NSDictionary *books = [self.shelves objectAtIndex:[indexPath row]];
    [booksViewController setCurrentShelf:[books objectForKey:@"Library"]];
    
    // Push View Controller onto Navigation Stack
    [self.navigationController pushViewController:booksViewController animated:YES];
}

@end
