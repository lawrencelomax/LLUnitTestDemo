#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "LLViewController.h"
#import "LLApiClient.h"

SpecBegin(LLViewControllerSpec)

describe(@"the view controller", ^{
	__block LLViewController *viewController;
	
	beforeEach(^{
		viewController = [[LLViewController alloc] init];
		[viewController view];
	});
	
	it(@"should configure with the second cat", ^{
		OCMockObject *mockImageView = [OCMockObject partialMockForObject:viewController.imageView];
		viewController.imageView = (UIImageView *)mockImageView;
		[[mockImageView expect] setImageWithURL:[OCMArg isNotNil]];
		
		[[LLApiClient sharedClient] firstCat];
		[viewController nextButtonPressed:viewController.nextButton];
		
		EXP_expect(viewController.catNameLabel.text).to.equal(@"long");
		[mockImageView verify];
	});
	
	it(@"should configure with the third cat", ^{
		[[LLApiClient sharedClient] firstCat];
		[viewController nextButtonPressed:viewController.nextButton];
		
		OCMockObject *mockImageView = [OCMockObject partialMockForObject:viewController.imageView];
		viewController.imageView = (UIImageView *)mockImageView;
		[[mockImageView expect] setImageWithURL:[OCMArg isNotNil]];
		
		[viewController nextButtonPressed:viewController.nextButton];

		EXP_expect(viewController.catNameLabel.text).to.equal(@"bullet");
		[mockImageView verify];
	});
	
	it(@"should configure with the first cat", ^{
		[[LLApiClient sharedClient] firstCat];
		[viewController nextButtonPressed:viewController.nextButton];
		
		OCMockObject *mockImageView = [OCMockObject partialMockForObject:viewController.imageView];
		viewController.imageView = (UIImageView *)mockImageView;
		[[mockImageView expect] setImageWithURL:[OCMArg isNotNil]];
		
		[viewController previousButtonPressed:viewController.nextButton];
		
		EXP_expect(viewController.catNameLabel.text).to.equal(@"grumpy");
		[mockImageView verify];
	});
});

SpecEnd
