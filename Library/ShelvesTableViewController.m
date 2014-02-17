

#import "ShelvesTableViewController.h"
#import "BooksTableViewController.h"
#import "LibModel/Library.h"
@interface ShelvesTableViewController ()

@property NSMutableArray *shelves;

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
- (void)setCurrentLibrary:(Library *)library {
    if (_currentLibrary != library) {
        _currentLibrary = library;
        self.shelves = library.shelves;
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = [self.shelves count];
   
    return count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
 
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
    [cell.textLabel setText:shelf.name];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}



#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    BooksTableViewController *booksViewController = [[BooksTableViewController alloc] init];
     [booksViewController.tableView setAllowsSelectionDuringEditing:TRUE];
    Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
    [booksViewController setCurShelf:shelf];
    [self.navigationController pushViewController:booksViewController animated:YES];
    
}

@end
