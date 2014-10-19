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
#import "AppDelegate.h"
#import "ShareBar.h"
#import "VirusGenerator.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController (){
    
    ShareBar *shareBar;
    __weak IBOutlet UIImageView *topTitleImage;
    __weak IBOutlet UIButton *takeQuizButton;
    __weak IBOutlet UIView *buttomBar;
    FBLoginView *fbLoginView;
    VirusGenerator *virusGenerator;
}

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    virusGenerator = [[VirusGenerator alloc] initWithFrame:self.view.frame];
    
    [self.view insertSubview:virusGenerator atIndex:0];
    shareBar = [[ShareBar alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    shareBar.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 80);
    shareBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    shareBar.screenH = self.view.frame.size.height;
    shareBar.mode = ShareBarModeApp;
    
    [self.view addSubview:shareBar];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height - 48);
    [buttomBar.layer pop_addAnimation:animation forKey:@"slideIn"];
    [virusGenerator initVirusNumbers:8 + arc4random_uniform(5)];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [virusGenerator stopAndRemoveAll];
}

- (IBAction)showQuestionView:(id)sender {
    QuestionViewController *questionView =  [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    [self.navigationController pushViewController:questionView animated:YES];
    
}

- (IBAction)shareApp:(id)sender {
    [shareBar showMe];
}
@end
