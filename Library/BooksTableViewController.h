#import <UIKit/UIKit.h>
#import "LibModel/Shelf.h"
#import "LibModel/Book.h"

@interface BooksTableViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic) Shelf *currentShelf;
@property NSIndexPath *currentIndexPath;
@property BOOL update;
- (void)setCurShelf:(Shelf *)booksDict ;

- (IBAction)AddButtonAction:(id)sender;
- (IBAction)DeleteButtonAction:(id)sender;

@end
