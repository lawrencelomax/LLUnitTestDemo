//
//  LLCatController.m
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 15/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import "LLCatController.h"

@interface LLCatController()

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSArray *array;

@end

@implementation LLCatController

+ (instancetype) catControllerWithArray:(NSArray *)array {
	return [[self alloc] initWithArray:array];
}

- (instancetype) initWithArray:(NSArray *)array {
	if((self = [super init])) {
		self.array = array;
	}
	return self;
}

- (NSDictionary *) nextCat {
	NSUInteger integerIndex = 0;
	if(!self.index) {
		integerIndex = 0;
	} else if (self.index.integerValue < (NSInteger)self.array.count - 1){
		integerIndex = self.index.unsignedIntegerValue + 1;
	} else {
		integerIndex = 0;
	}
	
	NSDictionary *cat = self.array.count > 0 ? self.array[integerIndex] : nil;
	self.index = @(integerIndex);
	
	return cat;
}

- (NSDictionary *) previousCat {
	NSUInteger integerIndex = 0;
	if(!self.index) {
		integerIndex = 0;
	} else if (self.index.integerValue >= 1){
		integerIndex = self.index.unsignedIntegerValue - 1;
	} else {
		integerIndex = self.array.count > 0 ? self.array.count - 1 : 0;
	}
	
	NSDictionary *cat = self.array.count > 0 ? self.array[integerIndex] : nil;
	self.index = @(integerIndex);
	
	return cat;
}

@end
