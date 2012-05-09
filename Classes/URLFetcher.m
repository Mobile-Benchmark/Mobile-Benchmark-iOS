//
//  URLFetcher.m
//  MobileBenchmark
//
//  Created by Lion User on 27/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "URLFetcher.h"
#import "SBJson.h"

@implementation URLFetcher

- (id)init
{
    self = [super init];
    if (self)
    {
        parser = [[SBJsonParser alloc] init];
        writer = [[SBJsonWriter alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [parser release];
    [writer release];
    [response release];
    [super dealloc];    
}

- (NSString *)stringWithUrl:(NSURL *)url stringWithMethod:(NSString *)method stringWithBody:(NSData *)body
{
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] init] autorelease];
    [urlRequest setURL:url];
    [urlRequest setHTTPMethod:method];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Accept"];
    
    //set Body
    if (body != NULL) { 
        NSString *length = [NSString stringWithFormat:@"%d", [body length]];
        [urlRequest setValue:length forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:body];
    }    
        
    // Fetch the JSON response   
    NSError *error = [[NSError alloc] init];    
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];

 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}

- (id) objectWithUrl:(NSURL *)url objectWithMethod:(NSString *)method objectWithData:(NSData *) body
{
	NSString *jsonString = [self stringWithUrl:url stringWithMethod:method stringWithBody:body];
    
	// Parse the JSON into an Object
	return [parser objectWithString:jsonString error:NULL];
}

- (NSDictionary *) connect:(NSString *) url withMethod:(NSString *) method withBody:(NSData *) body
{
	id responseObject = [self objectWithUrl:[NSURL URLWithString:url] objectWithMethod:method objectWithData:body];
    
	NSDictionary *feed = (NSDictionary *)responseObject;
	return feed;
}

- (int) getStatusCode
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response; 
    return [httpResponse statusCode]; 
}

@end