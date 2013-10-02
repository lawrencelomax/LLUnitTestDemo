//
//  LLViewController.m
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 14/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import "LLViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "LLApiClient.h"

@interface LLViewController ()

@property (nonatomic, strong) LLApiClient *apiClient;

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.apiClient = [LLApiClient sharedClient];
	[LLApiClient getInformationsFromInternets];
}

- (IBAction) nextButtonPressed:(UIButton *)sender {
	NSDictionary *cat = self.apiClient.nextCat;

	self.catNameLabel.text = cat[@"name"];
	if(cat[@"image_url"]) {
		[self.imageView setImageWithURL:[NSURL URLWithString:cat[@"image_url"]]];
	}
}

- (IBAction) previousButtonPressed:(UIButton *)sender {
	NSDictionary *cat = self.apiClient.previousCat;
	
	self.catNameLabel.text = cat[@"name"];
	if(cat[@"image_url"]) {
		[self.imageView setImageWithURL:[NSURL URLWithString:cat[@"image_url"]]];
	}
}

@end
