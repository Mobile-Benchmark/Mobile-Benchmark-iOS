//
//  CPUTestController.m
//  iOSMobileBenchmark
//
//  Created by Lion User on 30/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPUTestController.h"

@implementation CPUTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    //Internet speedd tonen
    
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background_no_logo.png"]];
    self.navigationController.navigationBar.hidden = TRUE;
    self.view.backgroundColor = background;
    [background release];

    
    self.navigationController.navigationBar.hidden = FALSE;
    [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = FALSE;
    [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
}

- (void)startTheBackgroundJob{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [NSThread sleepForTimeInterval:3];
    
    singletonSettings *settings = [singletonSettings sharedSingleton];
    
    //CPU score instellen
    NSInteger score = 9999;
    [settings setCPUTestScore:score];
    
    //Controleren of door moet gaan naar volgende test
    NSInteger status = [settings IsTestingAll];
    if(1 == status)
    {
        IOSpeedTestController *vc = [[IOSpeedTestController alloc ] init ];   
        [self.view addSubview:vc.view];
    }
    
    [pool release];
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

@end
