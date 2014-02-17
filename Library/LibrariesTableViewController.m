

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
                                  initWithTitle:@"Edit"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(EditTable:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
//    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
//                                     initWithTitle:@"-"
//                                     style:UIBarButtonItemStyleBordered
//                                     target:self
//                                     action:@selector(DeleteButtonAction:)];
//   
    //[self.navigationItem setRightBarButtonItem:addButton];
   // [self.navigationItem setLeftBarButtonItem:deleteButton];
    
}



//- (void)tableView:(UITableView *)aTableView
//                  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//                  forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        int row =indexPath.row;
//        [self.libraries removeObjectAtIndex:row];
//        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
//
//    }
//}

- (void)tableView:(UITableView *)aTableView
         commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
         forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.libraries removeObjectAtIndex:indexPath.row];
        [aTableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self AddButtonAction:self];
        [aTableView reloadData];
    }
}

- (IBAction)AddButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Library Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.update=false;
    [alertView show];

}

- (IBAction)EditButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Library Name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.update = true;
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *libNameField = [alertView textFieldAtIndex:0];
        if(self.update){
            static NSString *CellIdentifier = @"Cell Identifier";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                            forIndexPath:self.currentIndexPath];
            [cell.textLabel setText:libNameField.text];
            Library* lib = [self.libraries objectAtIndex:self.currentIndexPath.row];
            lib.name = libNameField.text;
            
        }else{
            Library *lib = [[Library alloc] init];
            
            lib.name = libNameField.text;
            [self.libraries addObject:lib];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.libraries indexOfObject:lib] inSection:0];
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
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    int count = [self.libraries count];
    bool editing = self.editing;
    if(editing){
        count++;
    }
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) {
        return UITableViewCellEditingStyleNone;
    }else if (self.editing && indexPath.row == ([self.libraries count])) {
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
    int rowcount = editing? [self.libraries count]: [self.libraries count]+1;
    if(row < rowcount )
    {
        Library *library = [self.libraries objectAtIndex:[indexPath row]];
        [cell.textLabel setText:library.name];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
//        textField.placeholder = @"Enter Text";
//        textField.text = @"fdf";
//        textField.tag = indexPath.row/2;
//        [textField setEnabled:false];
//       // textField.delegate = self;
//        [cell.contentView addSubview:textField];
       
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
        if(indexPath.row < self.libraries.count){
            self.currentIndexPath = indexPath;
            [self EditButtonAction:self];
        }else{
            self.currentIndexPath = indexPath;
            [self AddButtonAction:self];
        }
    }else{
        
        ShelvesTableViewController *shelvesViewController = [[ShelvesTableViewController alloc] init];
        [shelvesViewController.tableView setAllowsSelectionDuringEditing:TRUE];

         Library *library = [self.libraries objectAtIndex:[indexPath row]];
        [shelvesViewController setCurrentLibrary:library];
        [self.navigationController pushViewController:shelvesViewController animated:YES];
    }
}

@end
