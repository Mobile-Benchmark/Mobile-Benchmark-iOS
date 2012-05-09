//
//  IOSpeedTestController.m
//  iOSMobileBenchmark
//
//  Created by Lion User on 30/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IOSpeedTestController.h"

@implementation IOSpeedTestController

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
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
    
    //IO score instellen
    NSInteger score = 400;
    [settings setIOScore:score];
    
    //Controleren of door moet gaan naar volgende test
    NSInteger compare = 1;
    NSInteger status = [settings IsTestingAll];
    if(compare == status)
    {
        InternetSpeedTestController *vc = [[InternetSpeedTestController alloc ] init ];   
        //[self.navigationController pushViewController:vc animated:YES];
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
