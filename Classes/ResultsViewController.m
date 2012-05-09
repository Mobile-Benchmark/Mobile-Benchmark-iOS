//
//  ResultsViewController.m
//  MobileBenchmark
//
//  Created by Lion User on 28/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultsViewController.h"

@implementation ResultsViewController

@synthesize hardwareScore, ioScore, cpuScore, internetSpeedScore, submitButton, totalScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        urlfetcher = [[URLFetcher alloc] init];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        urlfetcher = [[URLFetcher alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
         urlfetcher = [[URLFetcher alloc] init];
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

    [self loadScores];
}

-(void)viewWillAppear:(BOOL)animated
{
  [self loadScores];
}


- (void)loadScores
{
    singletonSettings *settings = [singletonSettings sharedSingleton];
    
    NSInteger temp = [settings scoreHardwareTest];
    scoreHardware = [NSString stringWithFormat:@"%i", temp];
    [hardwareScore setText:scoreHardware];
    
    temp = [settings totalScore];
    scoreTotal = [NSString stringWithFormat:@"%i", temp];
    [totalScore setText:scoreTotal];
    
    temp = [settings scoreIOTest];
    scoreIOTest = [NSString stringWithFormat:@"%i", temp];
    [ioScore setText:scoreIOTest];
    
    temp = [settings scoreCPUTest];
    scoreCPUTest = [NSString stringWithFormat:@"%i", temp];
    [cpuScore setText:scoreCPUTest];
    
    temp = [settings scoreInternetSpeedTest];
    scoreInternetTest = [NSString stringWithFormat:@"%i", temp];
    [internetSpeedScore setText:scoreInternetTest];
    
}


- (IBAction)submitScores:(id)sender
{
    singletonSettings *settings = [singletonSettings sharedSingleton];
    
    if([settings totalScore] != [settings submittedScore] || [settings totalScore] == 0)
    {
        
        if([settings scoreInternetSpeedTest] != 0 && [settings scoreCPUTest] != 0
           && [settings scoreIOTest] != 0 && [settings scoreHardwareTest] != 0)
        {
            [NSThread detachNewThreadSelector:@selector(makeTheJSON) toTarget:self withObject:nil];
            [submitButton setEnabled:NO];
            
            activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            CGRect activityFrame = CGRectMake(130, 100, 50, 50);
            [activity setFrame:activityFrame];
            [activity startAnimating];
            [self.view addSubview:activity];
            [activity release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please run all tests before submitting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Already submitted this Benchmark" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
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


-(void)makeTheJSON
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    singletonSettings *settings = [singletonSettings sharedSingleton];
    
    NSMutableArray *resultarray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:IO_STORAGE_TEST_INTERN forKey:@"test" ];
    [result setObject:[NSString stringWithFormat:@"%i", [settings scoreIOTest]] forKey:@"score"];
    [result setObject:@"true" forKey:@"successful" ];
    [resultarray addObject:result];
    
    result = [[NSMutableDictionary alloc] init];
    [result setObject:IO_STORAGE_TEST_EXTERN forKey:@"test"];
    [result setObject:[NSString stringWithFormat:@"%i", [settings scoreIOTest]] forKey:@"score"];
    [result setObject:@"false" forKey:@"successful"];
    [resultarray addObject:result];
    
    result = [[NSMutableDictionary alloc] init];
    [result setObject:CPU_TEST forKey:@"test"];
    [result setObject:[NSString stringWithFormat:@"%i", [settings scoreCPUTest]] forKey:@"score"];
    [result setObject:@"true" forKey:@"successful"];
    [resultarray addObject:result];
    
    result = [[NSMutableDictionary alloc] init];
    [result setObject:HARDWARE_INFORMATION forKey:@"test"];
    [result setObject:[NSString stringWithFormat:@"%i", [settings scoreHardwareTest]] forKey:@"score"];
    [result setObject:@"true" forKey:@"successful"];
    [resultarray addObject:result];
    
    result = [[NSMutableDictionary alloc] init];
    [result setObject:INTERNET_SPEED_TEST forKey:@"test"];
    [result setObject:[NSString stringWithFormat:@"%i", [settings scoreInternetSpeedTest]] forKey:@"score"];
    [result setObject:@"true" forKey:@"successful"];
    [resultarray addObject:result];
    
    NSString *device = [[UIDevice currentDevice] uniqueIdentifier];
    NSLog(@"device ID : %@", device);
    
    NSString *version = [[UIDevice currentDevice] model];
    
    NSMutableDictionary *totaaldict = [[NSMutableDictionary alloc] init];
    [totaaldict setObject:device forKey:@"phoneid"];
    [totaaldict setObject:version  forKey:@"device"];
    [totaaldict setObject:@"Apple"  forKey:@"brand"];
    [totaaldict setObject:@"3"  forKey:@"total_score"];
    [totaaldict setObject:resultarray forKey:@"results"];
    
    
    NSString *jsonrequest = [totaaldict JSONRepresentation];
    NSData *datajson = [jsonrequest dataUsingEncoding:NSUTF8StringEncoding];  
    
    NSLog(@"JSON %@", jsonrequest);
    
    NSString *test = [urlfetcher stringWithUrl:[NSURL URLWithString:@"http://mobilebenchmarkdev.appspot.com/custom/PostTestResultsWithPhoneKey/"] stringWithMethod:@"POST" stringWithBody:datajson];     
    
    if([urlfetcher getStatusCode]==200)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit succeeded" message:@"Score Submitted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        //submitted score instellen 
        singletonSettings *settings = [singletonSettings sharedSingleton];
        [settings setSubmittedScore:scoreTotal];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong with submitting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    [submitButton setEnabled:YES];
    [activity removeFromSuperview];
    
    NSLog(@"Response %@", test);
    NSLog(@"phoneid: %@", device);
    
    [pool release];
    
}

- (void)dealloc
{    
    [urlfetcher release];
    [hardwareScore release];
    [ioScore release];
    [cpuScore release];
    [internetSpeedScore release];
    [submitButton release];
    [totalScore release];
    [super dealloc];
}

@end
