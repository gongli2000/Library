#import <UIKit/UIKit.h>
#import "LibModel/Shelf.h"
@interface BooksTableViewController : UITableViewController

@property (nonatomic) Shelf *currentShelf;
- (void)setCurShelf:(Shelf *)booksDict ;

@end
