//
//  URLFetcher.h
//  MobileBenchmark
//
//  Created by Lion User on 27/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SBJsonParser;
@class SBJsonWriter;

@interface URLFetcher : NSObject 
{    
    @private 
    NSURLResponse *response; 
    SBJsonParser *parser;
    SBJsonWriter *writer;
}

- (NSString *)stringWithUrl:(NSURL *)url stringWithMethod:(NSString *)method stringWithBody:(NSData *)body;
- (id) objectWithUrl:(NSURL *)url objectWithMethod:(NSString *)method objectWithData:(NSData *) body;
- (NSDictionary *) connect:(NSString *) url withMethod:(NSString *)method withBody:(NSData *) body;
- (int) getStatusCode;
@end
