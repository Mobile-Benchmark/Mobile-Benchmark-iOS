//
//  ResultTableViewController.m
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HistoryResultTableViewController.h"

@implementation HistoryResultTableViewController

@synthesize benchmarkKey;

- (id)init
{
    self = [super init];
    if (self)
    {
        fether = [[URLFetcher alloc] init];
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad results");
    self.navigationItem.title = @"Benchmark Result";
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect activityFrame = CGRectMake(130, 100, 50, 50);
    [activity setFrame:activityFrame];
    [activity startAnimating];
    [self.view addSubview:activity];
    [activity release];
    
    [self performSelectorOnMainThread:@selector(fetchResults) withObject:nil waitUntilDone:NO];  
    
    //Set the title  

}

- (void)fetchResults
{
     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (!testList) 
    {
        //Initialize the array.
        testList = [[NSMutableArray alloc] init];    
        scoreList = [[NSMutableArray alloc] init]; 
        
        NSMutableString *url = [[NSMutableString alloc] init];
        [url setString:@"http://mobilebenchmarkdev.appspot.com/custom/TestResultsFromBenchmarkKey/"];
        [url appendString:benchmarkKey];
        
        NSDictionary *dict = [fether connect:url withMethod:@"GET" withBody:NULL];
        if ([fether getStatusCode] == 200)
        {        
            NSDictionary *list = [dict valueForKey:@"list"];                
            NSArray *testResults = (NSArray *)[list valueForKey:@"TestResult"];
        
            int ndx;
            NSDictionary *testResult;
            for (ndx = 0; ndx < testResults.count; ndx++)
            {
                testResult = (NSDictionary *)[testResults objectAtIndex:ndx];
            
                NSMutableString *totalString;
                totalString = [[NSMutableString alloc] init];
            
            
                NSString *score = [NSString stringWithFormat:@"%@", [testResult valueForKey:@"score"]];
                NSString *category = [NSString stringWithFormat:@"%@", [testResult valueForKey:@"category"]];
                NSString *name = [NSString stringWithFormat:@"%@", [testResult valueForKey:@"name"]];
            
                
            
                [scoreList addObject:score]; 
                [testList addObject:name];
                //release
                
                [totalString release];
            }
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
    return [testList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCellHistoryResult";
	
    CustomCellHistoryResult *cell = (CustomCellHistoryResult*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCellHistoryResult" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCellHistoryResult *) currentObject;
				break;
			}
		}
	}
    
	cell.testLabel.text = [testList objectAtIndex:indexPath.row];
	cell.scoreLabel.text = [scoreList objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[testList release];
    [scoreList release];
    [super dealloc];
}