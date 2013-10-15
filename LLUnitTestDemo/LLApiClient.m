//
//  LLApiClient.m
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 2/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import "LLApiClient.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface LLApiClient ()

@property (nonatomic, strong) NSArray *localData;
@property (nonatomic, strong) NSArray *remoteData;

@end

@implementation LLApiClient

+ (instancetype) sharedClient {
	static LLApiClient *sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[LLApiClient alloc] initWithFileName:@"cat_list"];
	});
	
	return sharedClient;
}

- (instancetype) initWithFileName:(NSString *)fileName {
	if((self = [super init])) {
		self.localData = [LLApiClient fetchLocalData:fileName];
	}
	return self;
}

+ (NSArray *) fetchLocalData:(NSString *)fileName {
	NSData * data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:fileName withExtension:@"json"]];
	return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] ?: @[];
}

- (LLCatController *) catControllerWithUpdates:( void (^)(LLCatController *) )updateBlock {
	[self remoteData:^(NSArray *data) {
		if(updateBlock) updateBlock( [LLCatController catControllerWithArray:data] );
	}];
	
	NSArray *array = self.remoteData ?: self.localData ?: @[];
	return [LLCatController catControllerWithArray:array];
}

- (void) remoteData:( void(^)(NSArray *data) )getter {
	AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
	[manager GET:@"https://rawgithub.com/lawrencelomax/6790676/raw/2bd4fe1b9aa5d3983e24cffda593ec80098e20cb/cat_list.json"
	  parameters:nil
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
			 getter(responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
}

@end
