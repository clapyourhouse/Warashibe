
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController3 : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate,NSFetchedResultsControllerDelegate>
{
    //NSArray *items_;
    NSMutableArray *searchData;
    NSFetchRequest *fetchRequest;
    NSManagedObjectContext *managedObjectContext;
    NSArray *result;
    NSFetchedResultsController *fetchedResultsController;
}
@property(nonatomic,retain)NSMutableArray *searchData;
@property(nonatomic,retain) NSFetchRequest *fetchRequest;
@property(nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain) NSArray *result;
@property(nonatomic,retain) NSFetchedResultsController *fetchedResultsController;

- (void)loadAllPerson;
- (void)PredicatePerson;



@end
