//
//  InternetSpeedTestController.m
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InternetSpeedTestController.h"

@implementation InternetSpeedTestController

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
    //Internet speed tonen
    
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
    
    //Internetspeed score instellen
    NSInteger score = 1100;
    [settings setInternetSpeedTestScore:score];
    
    //Controleren of door moet gaan naar volgende test
    NSInteger status = [settings IsTestingAll];
    if(status == 1)
    {
        NSLog(@"check");
        self.tabBarController.selectedIndex = 1;
        [settings setIsTestingAll:0];
    }
    
    [pool release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
