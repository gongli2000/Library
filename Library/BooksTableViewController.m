

#import "BooksTableViewController.h"


@interface BooksTableViewController ()



@end

@implementation BooksTableViewController

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
    self.title = @"Books";

    
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
        [self.currentShelf.books   removeObjectAtIndex:indexPath.row];
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
        UITextField *booktitle = [alertView textFieldAtIndex:0];
        if(self.update){
            static NSString *CellIdentifier = @"Cell Identifier";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                         forIndexPath:self.currentIndexPath];
            Book* book = [self.currentShelf.books objectAtIndex:self.currentIndexPath.row];
            book.title = booktitle.text;
            [self.tableView beginUpdates];
            [cell.textLabel setText:booktitle.text];
            [self.tableView endUpdates];
            
            
        }else{
            Book *book = [[Book alloc] init];
            
            book.title = booktitle.text;
            [self.currentShelf.books addObject:book];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.currentShelf.books indexOfObject:book] inSection:0];
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
- (void)setCurShelf:(Shelf *)shelf {
    if (self.currentShelf != shelf) {
        self.currentShelf = shelf;
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = [self.currentShelf.books count];
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
    }else if (self.editing && indexPath.row == ([self.currentShelf.books count])) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    int row = indexPath.row;
    bool editing = self.editing;
    int rowcount = editing? [self.currentShelf.books count]: [self.currentShelf.books count]+1;
    if(row < rowcount )
    {
        Book *book = [self.currentShelf.books objectAtIndex:[indexPath row]];
        [cell.textLabel setText:book.title];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     
        
        
    }else{
        [cell.textLabel setText:@"add new row"];
        
    }
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
    
    
    if(self.editing)
    {
        if(indexPath.row < self.currentShelf.books.count){
            self.currentIndexPath = indexPath;
            [self EditButtonAction:self];
        }else{
            self.currentIndexPath = indexPath;
            [self AddButtonAction:self];
        }
    }
}

@end
