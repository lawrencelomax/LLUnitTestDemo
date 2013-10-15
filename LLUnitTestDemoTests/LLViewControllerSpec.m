#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "LLViewController.h"
#import "LLApiClient.h"

SpecBegin(LLViewControllerSpec)

describe(@"the view controller", ^{
	describe(@"configuring views", ^{
		it(@"should configure the cat view",^{
			UIImageView *imageView = [[UIImageView alloc] init];
			OCMockObject *mockImageView = [OCMockObject partialMockForObject:imageView];
			imageView = (UIImageView *) mockImageView;
			UILabel *label = [[UILabel alloc] init];
			
			[[mockImageView expect] setImageWithURL:[NSURL URLWithString:@"http://yo.gif"]];
			
			[LLViewController configureLabel:label imageView:imageView cat:@{ @"name" : @"foo", @"image_url" : @"http://yo.gif" }];
			
			EXP_expect(label.text).to.equal(@"foo");
			[mockImageView verify];
		});
	});
	
	describe(@"next/previous", ^{
		__block LLViewController *viewController;
		__block OCMockObject *apiClientMock;
				
		beforeEach(^{
			viewController = [[LLViewController alloc] init];
			apiClientMock = [OCMockObject mockForClass:LLApiClient.class];
            [[[[apiClientMock stub] classMethod] andReturn:apiClientMock] sharedClient];

			LLCatController *catController = [LLCatController catControllerWithArray:@[@{@"name" : @"0"}, @{@"name" : @"1"}, @{@"name" : @"2"}]];
			[[[apiClientMock stub] andReturn:catController] catControllerWithUpdates:[OCMArg any]];
			
			[viewController view];
		});
        
        afterEach(^{
            [apiClientMock stopMocking];
        });
		
		it(@"should configure with the first cat", ^{
			OCMockObject *mockClass = [OCMockObject mockForClass:LLViewController.class];
			[[[mockClass expect] classMethod] configureLabel:viewController.catNameLabel imageView:viewController.imageView cat:@{@"name" : @"0"}];
			
			[viewController nextButtonPressed:viewController.nextButton];
			
			[mockClass verify];
            [mockClass stopMocking];
		});
	});
});

SpecEnd
