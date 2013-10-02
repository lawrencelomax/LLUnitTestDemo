#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "LLApiClient.h"

@interface LLApiClient(Spec)

- (NSArray *) theRightArrayOfCats;
+ (void) cachedInformationFromInternets:(void (^)(NSArray *) )getter;
- (void) localData:( void (^)(NSArray *) )getter;

@end

SpecBegin(LLApiClientSpec)

describe(@"the api client", ^{
	it(@"should get the first cat", ^{
		NSString *catName = [[LLApiClient sharedClient] nextCat][@"name"];
		EXP_expect(catName).to.equal(@"grumpy");
	});
	
	it(@"should get the second cat", ^{
        [[LLApiClient sharedClient] nextCat];
		NSString *catName = [[LLApiClient sharedClient] nextCat][@"name"];
		EXP_expect(catName).to.equal(@"long");
	});
    
    it(@"should get the second cat if I go to the first cat first", ^{
        [[LLApiClient sharedClient] firstCat];
		NSString *catName = [[LLApiClient sharedClient] nextCat][@"name"];
		EXP_expect(catName).to.equal(@"long");
	});

    describe(@"getting cached cats", ^{
        it(@"should get cats from the internet first", ^{
            OCMockObject *classMock= [OCMockObject mockForClass:LLApiClient.class];
            
            [[[classMock expect] classMethod] cachedInformationFromInternets:[OCMArg any]];
            
            [[LLApiClient sharedClient] theRightArrayOfCats];
            
            [classMock verify];
            [classMock stopMocking];
        });
        
        it(@"should then try and get the local data",^{
            OCMockObject *partialMock= [OCMockObject partialMockForObject:[LLApiClient sharedClient]];
            [[partialMock expect] localData:[OCMArg any]];
            
            LLApiClient *client = (id)partialMock;
            
            // What if cachedInformationFromInternets returns data in the test?
            [client theRightArrayOfCats];
            
            [partialMock verify];
            [partialMock stopMocking];
        });
    });
});

SpecEnd
