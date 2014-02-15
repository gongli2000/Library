
#import <UIKit/UIKit.h>
#import "LibModel/Library.h"
#import "LibModel/Shelf.h"
#import "LibModel/Book.h"
@interface LibrariesTableViewController : UITableViewController<UIAlertViewDelegate>

@property NSMutableArray *libraries;
@property NSIndexPath *currentIndexPath;
@property BOOL update;
- (IBAction)AddButtonAction:(id)sender;
- (IBAction)DeleteButtonAction:(id)sender;

@end
