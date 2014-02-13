#import <UIKit/UIKit.h>

@interface BooksTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *currentBooks;
- (void)setCurrentShelf:(NSArray *)booksDict ;

@end
