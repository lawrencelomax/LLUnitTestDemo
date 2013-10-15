#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "LLApiClient.h"

@interface LLApiClient (Spec)

- (instancetype) initWithFileName:(NSString *)fileName;

@end

@interface LLCatController (LLApiClientSpec)

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSArray *array;

@end

SpecBegin(LLApiClientSpec)

describe(@"the api client", ^{
    __block LLApiClient *apiClient;
    
    beforeEach(^{
        apiClient = [[LLApiClient alloc] initWithFileName:@"cat_list"];
    });
    
    it(@"the client should immediately return some data", ^{
        LLCatController *catController = [apiClient catControllerWithUpdates:NULL];
        
        EXP_expect(catController.array).toNot.beNil();
    });
});

SpecEnd
