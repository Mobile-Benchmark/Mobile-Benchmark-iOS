//
//  MobileBenchmarkViewController.m
//  MobileBenchmark
//
//  Created by Lion User on 26/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MobileBenchmarkViewController.h"

@implementation MobileBenchmarkViewController



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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background_nonretina.png"]];
    self.navigationController.navigationBar.hidden = TRUE;
    self.view.backgroundColor = background;
    [background release];
} 

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = true;
}

- (IBAction)doBenchmarkAll:(id)sender
{
    singletonSettings *settings = [singletonSettings sharedSingleton];
    [settings setIsTestingAll:1];
    
    HardwareTestController *vc = [[HardwareTestController alloc ] init];   
	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dogetHistory:(id)sender
{
    HistoryTableViewController *wltvc = [[HistoryTableViewController alloc] init];
    [self.navigationController pushViewController:wltvc animated:YES];
    [wltvc release];
}

- (IBAction)doCPUTestBenchmark:(id)sender
{
    CPUTestController *wltvc = [[CPUTestController alloc] init];
    [self.navigationController pushViewController:wltvc animated:YES];
    [wltvc release];
}

- (IBAction)doIOSpeedTestBenchmark:(id)sender
{
    IOSpeedTestController *wltvc = [[IOSpeedTestController alloc] init];
    [self.navigationController pushViewController:wltvc animated:YES];
    [wltvc release];
}

- (IBAction)doInternetSpeedBenchmark:(id)sender;
{
    InternetSpeedTestController *vc = [[InternetSpeedTestController alloc ] init ];   
	[self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)doHardwareBenchmark:(id)sender
{
    HardwareTestController *vc = [[HardwareTestController alloc ] init];   
	[self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)dogetResults:(id)sender
{
    
    ResultsViewController *vc = [[ResultsViewController alloc ] init ];   
	[self.navigationController pushViewController:vc animated:YES];
    [vc release];
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

- (void)dealloc
{

}
@end
