#import "HistoryTableViewController.h"
#import "HistoryResultTableViewController.h"

@interface HistoryTableViewController()
@property (retain) NSMutableArray *indexToBenchmarkKey;
@end

@implementation HistoryTableViewController

@synthesize indexToBenchmarkKey;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"History";
}

- (void)fetchHistory
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    fether = [[URLFetcher alloc] init];
  
    //Initialize the array.
    scoreList = [[NSMutableArray alloc] init];
    datumList = [[NSMutableArray alloc] init];
    indexToBenchmarkKey = [[NSMutableArray alloc] init];      
    NSString *phoneID = [[UIDevice currentDevice] uniqueIdentifier];
       
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://mobilebenchmarkdev.appspot.com/custom/BenchmarksFromPhoneID/"];
    [url appendString:phoneID];
        
    NSDictionary *dict = [fether connect:url withMethod:@"GET" withBody:NULL];
    if ([fether getStatusCode] == 200)
    {
        NSDictionary *list = [dict valueForKey:@"list"];                
        NSArray *benchmarks = (NSArray *)[list valueForKey:@"Benchmark"];
        
        int ndx;
        NSDictionary *benchmark;
        for (ndx = 0; ndx < benchmarks.count; ndx++)
        {
            benchmark = (NSDictionary *)[benchmarks objectAtIndex:ndx];
                    
            NSMutableString *totalString;
            totalString = [[NSMutableString alloc] init];
            
            [totalString setString:@"Score: "];            
            NSString *total_score = [NSString stringWithFormat:@"%@", [benchmark valueForKey:@"total_score"]];
            NSString *time = [NSString stringWithFormat:@"%@", [benchmark valueForKey:@"timestamp"]];
            NSString *key = [NSString stringWithFormat:@"%@", [benchmark valueForKey:@"key"]];
            
            //[totalString appendString:total_score];
            //[totalString appendString:@" Time:"];   
           // [totalString appendString:time];
            [scoreList addObject:total_score];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.SSS"];
            NSDate *date = [dateFormat dateFromString:time];
            [dateFormat setDateFormat:@"MMMM d, YYYY 'at' HH:mm:ss"];
            [datumList addObject:[dateFormat stringFromDate:date]];
            //[listOfItems addObject:totalString]; 
            [indexToBenchmarkKey addObject:key];
            //release
            [totalString release];
        }
        [url release];
    }
    [self.tableView reloadData];
    [activity removeFromSuperview];
    [pool release];
}

             
                                    
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [scoreList count];
}

- (void)viewWillAppear:(BOOL)animated
{    
    NSLog(@"ViewWillappear histroy");
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect activityFrame = CGRectMake(130, 100, 50, 50);
    [activity setFrame:activityFrame];
    [activity startAnimating];
    [self.view addSubview:activity];
    [activity release];
    
    [self performSelectorOnMainThread:@selector(fetchHistory) withObject:nil waitUntilDone:NO];   
}
// Customize the appearance of table view cells.
/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCellHistory";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // create cell
	NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
	cell.textLabel.text = cellValue;
    
    return cell;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCellHistory";
	
    CustomCellHistory *cell = (CustomCellHistory *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCellHistory" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCellHistory *) currentObject;
				break;
			}
		}
	}
    
	cell.dateLabel.text = [datumList objectAtIndex:indexPath.row];
	cell.scoreLabel.text = [scoreList objectAtIndex:indexPath.row];
    return cell;
}

- (NSString *)resultKeyAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.indexToBenchmarkKey objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

	HistoryResultTableViewController *dvc = [[HistoryResultTableViewController alloc] init];
	dvc.benchmarkKey = [self resultKeyAtIndexPath:indexPath];
	[self.navigationController pushViewController:dvc animated:YES];
	[dvc release];
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDetailDisclosureButton;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{    
    [fether release];
	[scoreList release];
    [datumList release];
    [indexToBenchmarkKey release];
    [super dealloc];
}

@end
