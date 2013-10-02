//
//  LLViewController.h
//  LLUnitTestDemo
//
//  Created by Lawrence Lomax on 14/10/13.
//  Copyright (c) 2013 Lawrence Lomax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *catNameLabel;

@property (nonatomic, strong) IBOutlet UIButton *previousButton;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

- (IBAction) nextButtonPressed:(UIButton *)sender;
- (IBAction) previousButtonPressed:(UIButton *)sender;

@end
