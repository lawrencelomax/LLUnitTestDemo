//
//  LLApiClient.m
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 2/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import "LLApiClient.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation LLApiClient

+ (instancetype) sharedClient {
	static LLApiClient *sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[LLApiClient alloc] init];
	});
	
	return sharedClient;
}

static NSUInteger catIndex = 0;
BOOL isFirstTime = YES;

- (NSDictionary *) firstCat {
	isFirstTime = YES;
	
	return self.nextCat;
}

- (NSDictionary *) nextCat {
	NSArray *cats = self.theRightArrayOfCats;
		
	if(catIndex < (NSInteger)cats.count - 1){
		catIndex++;
	}
	if(isFirstTime) {
		catIndex = 0;
		isFirstTime = NO;
	}
	
	id cat = cats[catIndex];
	return cat;
}

- (NSDictionary *) previousCat {
	NSArray *cats = self.theRightArrayOfCats;
	
	if(catIndex > 0) {
		catIndex--;
	}
	
	id cat = cats[catIndex];
	return cat;
}

- (NSArray *) theRightArrayOfCats {
	__block NSArray *array = nil;
	
	[LLApiClient cachedInformationFromInternets:^(NSArray *cached) {
		array = cached;

		if(!cached) {
			[[LLApiClient sharedClient] localData:^(NSArray *cached) {
				array = cached;
			}];
		}
	}];
	
	return array;
}

- (void) localData:( void (^)(NSArray *) )getter {
	static NSArray *array = nil;
	if(!array) {
		NSData * data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"cat_list" withExtension:@"json"]];
		array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		catIndex = 0;
	}
	getter(array);
}

static NSArray *internetCats = nil;

+ (void) cachedInformationFromInternets:(void (^)(NSArray *) )getter {
	getter(internetCats);
}

+ (void) getInformationsFromInternets {
	// This method will download information from Internet and cache it
	// I'm just going to rely on assumptions about the implementation
	// of this method, because I hate my life
	[[LLApiClient sharedClient] remoteData:^(NSArray *data) {
		
	}];
}

- (void) remoteData:( void(^)(NSArray *) )getter {
	AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
	[manager GET:@"https://rawgithub.com/lawrencelomax/6790676/raw/2bd4fe1b9aa5d3983e24cffda593ec80098e20cb/cat_list.json"
	  parameters:nil
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
			 if(![responseObject isEqual:internetCats]) {
				 internetCats = responseObject;
				 catIndex = 0;
			 }
			 
			 getter(responseObject);
	  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		  NSLog(@"IM GOING TO DO ANYTHING WITH THIS, JUST PRINT OUT LOTS OF USELESS MESSAGES");
	}];
}

@end
