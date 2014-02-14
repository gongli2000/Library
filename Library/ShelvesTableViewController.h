
#import <UIKit/UIKit.h>
#import "LibModel/Library.h"

@interface ShelvesTableViewController : UITableViewController

@property (nonatomic) Library *currentLibrary;

- (IBAction)AddButtonAction:(id)sender;


- (IBAction)DeleteButtonAction:(id)sender;
    
@end
