//
//  HardwareTestController.m
//  MobileBenchmark
//
//  Created by Lion User on 27/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HardwareTestController.h"

@implementation HardwareTestController

@synthesize threadProgressView, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (void) getVersionNumber
{
    printf("Starting benchmarks...");
    if([self getSystemVersionAsAnInteger] >= (NSInteger)__IPHONE_4_0)
    {
        printf("equal or higher than iphone 4.0" );
    } else 
    {
        printf("Older than iphone 4.0");
    }
}

- (NSInteger) getSystemVersionAsAnInteger
{
    int index = 0;
    NSInteger version = 0;
    
    NSArray* digits = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSEnumerator* enumer = [digits objectEnumerator];
    NSString* number;
    while ((number = [enumer nextObject])) {
        if (index>2) {
            break;
        }
        NSInteger multipler = powf(100, 2-index);
        version += [number intValue]*multipler;
        index++;
    }
    return version;
}*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //hardware informatie tonen
    
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background_no_logo.png"]];
    self.navigationController.navigationBar.hidden = TRUE;
    self.view.backgroundColor = background;
    [tableView setBackgroundColor:[UIColor clearColor]];
    
    [background release];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = FALSE;
    [threadProgressView setProgress:0];
    [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
}

- (void)startTheBackgroundJob{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [self performSelectorOnMainThread:@selector(getHardwareVersion) withObject:nil waitUntilDone:NO];
    [NSThread sleepForTimeInterval:3];
    
    singletonSettings *settings = [singletonSettings sharedSingleton];

    //Hardware score instellen
    NSInteger score = 1000;
    [settings setHardwareScore:score];
    
    //Controleren of door moet gaan naar volgende test

    NSInteger status = [settings IsTestingAll];
    if(status == 1)
    {
        CPUTestController *vc = [[CPUTestController alloc ] init ];   
        //[self.navigationController pushViewController:vc animated:YES];
        [self.view addSubview:vc.view];
    }
    
    [pool release];
}

-(void)getHardwareVersion
{
   // NSInteger version = [self getSystemVersionAsAnInteger ];
    [[UIDevice currentDevice] description];
   // [hardwareVersion setText:[[UIDevice currentDevice] model]];
    printf("equal or higher than iphone 4.0" );
    
    //Progress bar updaten
    float actual = [threadProgressView progress];
    threadProgressView.progress = actual + 0.1;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [NSString	 stringWithFormat:@"Cell Row #%d", [indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// open a alert with an OK and cancel button
	NSString *alertString = [NSString stringWithFormat:@"Clicked on row #%d", [indexPath row]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)dealloc{
    
    [threadProgressView release];
    [tableView release];
    [super dealloc];
}

@end
