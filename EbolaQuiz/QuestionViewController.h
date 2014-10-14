//
//  QuestionViewController.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-12.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongAleartLabel;
@property (strong, nonatomic) IBOutlet UIView *wrongButtonBar;
@property (strong, nonatomic) IBOutlet UIView *questionButtonBar;


- (IBAction)shareQuestion:(id)sender;
- (IBAction)letMeTryAgain:(id)sender;
- (IBAction)shareResult:(id)sender;


@end
