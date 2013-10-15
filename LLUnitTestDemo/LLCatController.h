//
//  LLCatController.h
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 15/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCatController : NSObject

+ (instancetype) catControllerWithArray:(NSArray *)array;

- (NSDictionary *) nextCat;
- (NSDictionary *) previousCat;

@end
