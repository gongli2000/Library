#import <UIKit/UIKit.h>

@interface BooksTableViewController : UITableViewController

@property (nonatomic)  NSArray *currentBooks;
- (void)setCurrentShelf:(NSDictionary *)booksDict ;

@end
