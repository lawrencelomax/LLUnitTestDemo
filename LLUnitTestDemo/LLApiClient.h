//
//  LLApiClient.h
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 2/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLApiClient : NSObject

+ (instancetype) sharedClient;

+ (void) getInformationsFromInternets;

- (NSDictionary *) firstCat;
- (NSDictionary *) nextCat;
- (NSDictionary *) previousCat;

@end
