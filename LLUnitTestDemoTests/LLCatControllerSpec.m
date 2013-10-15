#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

#import "LLCatController.h"

SpecBegin(LLCatControllerSpec)

describe(@"the cat controller", ^{
	it(@"should return the first item", ^{
		LLCatController *catController = [LLCatController catControllerWithArray:@[@{@"order" : @0}, @{@"order" : @1}, @{@"order": @2}]];
		
		EXP_expect([catController nextCat]).to.equal(@{@"order" : @0});
	});
		
	it(@"should return the third item", ^{
		LLCatController *catController = [LLCatController catControllerWithArray:@[@{@"order" : @0}, @{@"order" : @1}, @{@"order": @2}]];
		
		[catController nextCat];
		[catController nextCat];
		EXP_expect([catController nextCat]).to.equal(@{@"order" : @2});
	});

});

SpecEnd
