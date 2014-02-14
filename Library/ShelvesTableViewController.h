
#import <UIKit/UIKit.h>
#import "LibModel/Library.h"

@interface ShelvesTableViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic) Library *currentLibrary;

- (IBAction)AddButtonAction:(id)sender;


- (IBAction)DeleteButtonAction:(id)sender;
    
@end
