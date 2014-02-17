

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
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
//                                  initWithTitle:@"+"
//                                  style:UIBarButtonItemStyleBordered
//                                  target:self
//                                  action:@selector(AddButtonAction:)];
//    //[self.navigationItem setRightBarButtonItem:addButton];
//    
//    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
//                                     initWithTitle:@"-"
//                                     style:UIBarButtonItemStyleBordered
//                                     target:self
//                                     action:@selector(DeleteButtonAction:)];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton,deleteButton,nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Edit"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(EditTable:)];
    [self.navigationItem setRightBarButtonItem:addButton];

}
- (void)tableView:(UITableView *)aTableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.shelves   removeObjectAtIndex:indexPath.row];
        [aTableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self AddButtonAction:self];
        [aTableView reloadData];
    }
}

- (IBAction)AddButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Shelf Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.update=false;
    [alertView show];
    
}

- (IBAction)EditButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Shelf Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.update = true;
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *shelfNameField = [alertView textFieldAtIndex:0];
        if(self.update){
            static NSString *CellIdentifier = @"Cell Identifier";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                         forIndexPath:self.currentIndexPath];
            Shelf* shelf = [self.shelves objectAtIndex:self.currentIndexPath.row];
            shelf.name = shelfNameField.text;
            [self.tableView beginUpdates];
            [cell.textLabel setText:shelfNameField.text];
            [self.tableView endUpdates];
           
            
        }else{
            Shelf *shelf = [[Shelf alloc] init];
            
            shelf.name = shelfNameField.text;
            [self.shelves addObject:shelf];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.shelves indexOfObject:shelf] inSection:0];
            [self.tableView beginUpdates];
            [self.tableView
             insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationBottom];
            [self.tableView endUpdates];
        }
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
- (IBAction) EditTable:(id)sender{
    if(self.editing)
    {
        [super setEditing:NO];
        [self setEditing:NO animated:NO];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    
    [self.tableView reloadData];
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
    bool editing = self.editing;
    if(editing){
        count++;
    }
    return count;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) {
        return UITableViewCellEditingStyleNone;
    }else if (self.editing && indexPath.row == ([self.shelves count])) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
 
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //   int count = 0;
    //   if(self.editing && indexPath.row != 0)
    //        count = 1;
    //
    
    int row = indexPath.row;
    bool editing = self.editing;
    int rowcount = editing? [self.shelves count]: [self.shelves count]+1;
    if(row < rowcount )
    {
        Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
        [cell.textLabel setText:shelf.name];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        [cell.textLabel setText:@"add new row"];
        
    }
    return cell;
}



#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.editing)
    {
        if(indexPath.row < self.shelves.count){
            self.currentIndexPath = indexPath;
            [self EditButtonAction:self];
        }else{
            self.currentIndexPath = indexPath;
            [self AddButtonAction:self];
        }
    }else{
        
        BooksTableViewController *booksViewController = [[BooksTableViewController alloc] init];
        Shelf *shelf = [self.shelves objectAtIndex:[indexPath row]];
        [booksViewController setCurShelf:shelf];
        [self.navigationController pushViewController:booksViewController animated:YES];
    }
}

@end
