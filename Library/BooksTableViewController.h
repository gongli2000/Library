#import <UIKit/UIKit.h>
#import "LibModel/Shelf.h"
@interface BooksTableViewController : UITableViewController

@property (nonatomic) Shelf *currentShelf;
- (void)setCurShelf:(Shelf *)booksDict ;

- (IBAction)AddButtonAction:(id)sender;
- (IBAction)DeleteButtonAction:(id)sender;

@end
