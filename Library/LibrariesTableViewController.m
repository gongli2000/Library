

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
    for(int libNum=0;libNum < [librariesFromFile count]; libNum++){
        Library *lib = [[Library alloc] init];
        NSDictionary* x =[librariesFromFile objectAtIndex: libNum] ;
        lib.name = [x objectForKey:@"Library"];
        NSArray* shelves = [x objectForKey: @"Shelves"];
        [lib addShelves: [shelves count]];
        for(int shelfNum=0; shelfNum < [shelves count] ; shelfNum++){
            NSArray* books = [shelves objectAtIndex: shelfNum];
            Shelf *shelf = [[Shelf alloc] init];
            shelf.name = [NSString stringWithFormat:@"Shelf %i", shelfNum];
            for(int bookNum=0;bookNum< [books count];bookNum++){
                Book *book =[[Book alloc] init];
                book.title =[books objectAtIndex: bookNum];
                [shelf.books addObject: book];
            }
            lib.shelves[shelfNum]=shelf;
        }
        self.libraries[libNum]= lib;
    }

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

    int count = [self.libraries count];
    return count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell Identifier";
//    
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Fetch Author
//    Library *library = [self.libraries objectAtIndex:[indexPath row]];
//    
//    // Configure Cell
//    [cell.textLabel setText:library.name];
//    
//    
//    return cell;
//}
// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Library *library = [self.libraries objectAtIndex:[indexPath row]];
    [cell.textLabel setText:library.name];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    ShelvesTableViewController *shelvesViewController = [[ShelvesTableViewController alloc] init];
    [shelvesViewController.tableView setAllowsSelectionDuringEditing:TRUE];

     Library *library = [self.libraries objectAtIndex:[indexPath row]];
    [shelvesViewController setCurrentLibrary:library];
    [self.navigationController pushViewController:shelvesViewController animated:YES];
  
}

@end
