

#import "LibrariesTableViewController.h"

#import "ShelvesTableViewController.h"

@interface LibrariesTableViewController ()

@end

@implementation LibrariesTableViewController

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
    
    self.title = @"Libraries";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
    NSArray * librariesFromFile = [NSArray arrayWithContentsOfFile:filePath];
    self.libraries = [[NSMutableArray alloc] init];
    for(int i=0;i < [librariesFromFile count]; i++){
        Library *lib = [[Library alloc] init];
        NSDictionary* x =[librariesFromFile objectAtIndex: i] ;
        lib.name = [x objectForKey:@"Library"];
        NSArray* shelves = [x objectForKey: @"Shelves"];
        [lib addShelves: [shelves count]];
        for(int j=0; j < [shelves count] ; j++){
            NSArray* books = [shelves objectAtIndex: j];
            Shelf *shelf = [[Shelf alloc] init];
            shelf.name = [NSString stringWithFormat:@"Shelf %i", j];
            for(int j=0;j< [books count];j++){
                [shelf.books setObject: [books objectAtIndex: j] forKey: [books objectAtIndex: j]];
            }
            lib.shelves[j]=shelf;
        }
        self.libraries[i]= lib;
    }
    
        
    
//    Library *lib = [[Library alloc] init];
//    [lib addShelves: 10];
//    Book* b1 = [[Book alloc] init:@"The dog and cat" author:@"sam shepard"];
//    [b1 enshelf: [lib getshelf: 0]];
//    [b1 unshelf: [lib getshelf:0]];
//    Book* b2 = [[Book alloc] init:@"title 2" author:@"sam shepard"];
//    [b2 enshelf: [lib getshelf:0]];
//    
//    Book* b3 = [[Book alloc] init:@"title 3" author:@"sam shepard"];
//    [b3 enshelf: [lib getshelf:0]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.libraries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch Author
    Library *library = [self.libraries objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:library.name];
    
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
    // Initialize Books View Controller
    ShelvesTableViewController *shelvesViewController = [[ShelvesTableViewController alloc] init];
    
    // Fetch and Set library
    Library *library = [self.libraries objectAtIndex:[indexPath row]];
    [shelvesViewController setCurrentLibrary:library];
    
    // Push View Controller onto Navigation Stack
    [self.navigationController pushViewController:shelvesViewController animated:YES];
}

@end
