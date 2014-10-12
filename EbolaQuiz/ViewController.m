//
//  ViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-9.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "ViewController.h"
#import "QuestionViewController.h"
#import "Pop.h"

@interface ViewController (){
    
    __weak IBOutlet UIImageView *topTitleImage;
    __weak IBOutlet UIButton *takeQuizButton;
    __weak IBOutlet UIView *buttomBar;
}

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height - 48);
    [buttomBar.layer pop_addAnimation:animation forKey:@"slideIn"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showQuestionView:(id)sender {
    QuestionViewController *questionView =  [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
//    [self presentViewController:questionView animated:YES completion:nil];
    [self.navigationController pushViewController:questionView animated:YES];
}

@end
