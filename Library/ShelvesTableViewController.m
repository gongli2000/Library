

#import "ShelvesTableViewController.h"
#import "BooksTableViewController.h"
#import "LibModel/Library.h"
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
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(AddButtonAction:)];
    //[self.navigationItem setRightBarButtonItem:addButton];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"-"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(DeleteButtonAction:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton,deleteButton,nil];

}
- (void)tableView:(UITableView *)aTableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        int row =indexPath.row;
        [self.currentLibrary.shelves removeObjectAtIndex:row];
        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
    }
}
- (IBAction)AddButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Shelf Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        Shelf *shelf = [[Shelf alloc] init];
        shelf.name = [alertView textFieldAtIndex:0].text;
        [self.currentLibrary.shelves addObject:shelf];
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:[self.currentLibrary.shelves indexOfObject:shelf]
                                  inSection:0];
        [self.tableView beginUpdates];
        [self.tableView
         insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
    }
}


- (IBAction)DeleteButtonAction:(id)sender{
    if(self.editing)
    {
        //[super setEditing:NO <span class="IL_AD" id="IL_AD1">animated</span>:NO];
        [self setEditing:NO animated:NO];
        
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self setEditing:YES animated:YES];
        
    }
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
    return [self.shelves count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch Books
    Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:shelf.name];
    
    return cell;
}



#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BooksTableViewController *booksViewController = [[BooksTableViewController alloc] init];
    Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
    [booksViewController setCurShelf:shelf];
    [self.navigationController pushViewController:booksViewController animated:YES];
}

@end
