
#import <UIKit/UIKit.h>
#import "LibModel/Library.h"

@interface ShelvesTableViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic) Library *currentLibrary;
@property BOOL update;
@property NSIndexPath *currentIndexPath;
- (IBAction)AddButtonAction:(id)sender;


- (IBAction)DeleteButtonAction:(id)sender;
    
@end
