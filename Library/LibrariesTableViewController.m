

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

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(AddButtonAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"-"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(DeleteButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:deleteButton];
    
}



- (void)tableView:(UITableView *)aTableView
                  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        int row =indexPath.row;
        [self.libraries removeObjectAtIndex:row];
        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];

    }
}
- (IBAction)AddButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Library Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alertView show];
    

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        Library *lib = [[Library alloc] init];
        UITextField *libNameField = [alertView textFieldAtIndex:0];
        lib.name = libNameField.text;
        [self.libraries addObject:lib];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.libraries indexOfObject:lib] inSection:0];
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
