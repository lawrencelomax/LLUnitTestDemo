//
//  LLViewController.m
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 14/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import "LLViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "LLCatController.h"
#import "LLApiClient.h"

@interface LLViewController ()

@property (nonatomic, strong) LLCatController *catController;

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	__weak LLViewController *weakSelf = self;
	self.catController = [[LLApiClient sharedClient] catControllerWithUpdates:^(LLCatController *catController) {
		weakSelf.catController = catController;
	}];
}

- (IBAction) nextButtonPressed:(UIButton *)sender {
	[LLViewController configureLabel:self.catNameLabel imageView:self.imageView cat:self.catController.nextCat];
}

- (IBAction) previousButtonPressed:(UIButton *)sender {
	[LLViewController configureLabel:self.catNameLabel imageView:self.imageView cat:self.catController.previousCat];
}

+ (void) configureLabel:(UILabel *)label imageView:(UIImageView *)imageView cat:(NSDictionary *)cat {
	label.text = cat[@"name"];
	if(cat[@"image_url"]) {
		[imageView setImageWithURL:[NSURL URLWithString:cat[@"image_url"]]];
	}
}

@end
