//
//  QuestionViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-12.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionObject.h"
#import "OptionItem.h"
#import "OptionObject.h"
#import "TFHpple.h"
#import "Pop.h"
#import "BlocksKit.h"
#import "ShareBar.h"
#import "VirusGenerator.h"
@interface QuestionViewController (){
    NSMutableArray *questionsItems;
    NSMutableArray *questions;
    UIImageView *questionImage;
    QuestionObject *currentQuestion;
    int questionIndex;
    ShareBar *shareBar;
    VirusGenerator *virusGenerator;
    float optionYStart;
    BOOL winOnShow;
}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    questionIndex = 0;
    winOnShow = NO;
    [self initQuestions];
    [self initView];
    CGRect tableFrame = self.questionButtonBar.frame;
    tableFrame.origin.y = self.view.frame.size.height - 90;
    [self.questionButtonBar setFrame:tableFrame];
    tableFrame = self.wrongButtonBar.frame;
    tableFrame.origin.y = self.view.frame.size.height;
    [self.wrongButtonBar setFrame:tableFrame];
    
    shareBar = [[ShareBar alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    shareBar.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 80);
    shareBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    shareBar.screenH = self.view.frame.size.height;
    shareBar.mode = ShareBarModeQuestion;
    [self.view addSubview:shareBar];
    virusGenerator = [[VirusGenerator alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:virusGenerator atIndex:0];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [virusGenerator initVirusNumbers:8 + arc4random_uniform(5)];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [virusGenerator stopAndRemoveAll];
}
-(void)initView{
    questionsItems = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        OptionItem *optionItem = [[OptionItem alloc] initWithFrame:CGRectMake(10, 120+i*60, 300, 50)];
        optionItem.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:optionItem];
        [questionsItems addObject:optionItem];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [optionItem addGestureRecognizer:tap];
    }
    currentQuestion = [questions objectAtIndex:0];
    [self showQuestion];
}
-(void)onTap:(UITapGestureRecognizer *)sender{
    OptionItem *item = (OptionItem *)sender.view;
    if ([currentQuestion isRight:item.optionObj.id]) {
        [self nextQuestion];
    }else
    {
        [self showWrongAnsewerAlert];
        [self showWrongAnsewerButtonBar];
        [self hideQuestionButtonBar];
        [self hideQuestionLabel];
        [self hideAllItem];
    }
    
}
-(void)showWrongAnsewerAlert{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(100);
    [self.wrongAleartLabel.layer pop_addAnimation:animation forKey:@"showWrongAnsewerAlert"];
}
-(void)hideWrongAnsewerAlert{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(-100);
    [self.wrongAleartLabel.layer pop_addAnimation:animation forKey:@"hideWrongAnsewerAlert"];
}
-(void)showWinAlert{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(100);
    [self.winLabel.layer pop_addAnimation:animation forKey:@"showWinAlert"];
    winOnShow = YES;
}
-(void)hideWinAlert{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(-150);
    [self.winLabel.layer pop_addAnimation:animation forKey:@"hideWinAlert"];
    winOnShow = NO;
}
-(void)showQuestionLabel{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(90);
    [self.questionLabel.layer pop_addAnimation:animation forKey:@"showQuestionLabel"];
}
-(void)hideQuestionLabel{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(-100);
    [self.questionLabel.layer pop_addAnimation:animation forKey:@"hideQuestionLabel"];
}
-(void)showWrongAnsewerButtonBar{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height - 45);
    [self.wrongButtonBar pop_addAnimation:animation forKey:@"showWrongAnsewerButtonBar"];
}
-(void)hideWrongAnsewerButtonBar{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height + 45);
    [self.wrongButtonBar.layer pop_addAnimation:animation forKey:@"hideWrongAnsewerButtonBar"];
}
-(void)showQuestionButtonBar{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height - 45);
    [self.questionButtonBar pop_addAnimation:animation forKey:@"showWrongAnsewerButtonBar"];
}
-(void)hideQuestionButtonBar{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(self.view.frame.size.height + 45);
    [self.questionButtonBar.layer pop_addAnimation:animation forKey:@"hideWrongAnsewerButtonBar"];
}
-(void)showAllItem{
    if (questionImage) {
        [questionImage setHidden:NO];
    }
    for (OptionItem *item in questionsItems) {
        [item setHidden:NO];
    }
}
-(void)hideAllItem{
    if (questionImage) {
        [questionImage setHidden:YES];
    }
    for (OptionItem *item in questionsItems) {
        [item setHidden:YES];
    }
}
-(void)initQuestions{
    questions = [NSMutableArray array];
    NSError *error;
    NSString *str=[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:str options:NSDataReadingMapped error:&error];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements  = [doc searchWithXPathQuery:@"//question"];
    for (int i = 0; i < elements.count; i++) {
        TFHppleElement *ele = elements[i];
        [questions addObject:[[QuestionObject alloc] initWithTFHppleElement:ele]];
    }
}

-(void)nextQuestion{
    if (questionIndex + 1 < questions.count) {
        questionIndex++;
        currentQuestion = questions[questionIndex];
        [self showQuestion];
    }else
    {
        [self showWinAlert];
        [self showWrongAnsewerButtonBar];
        [self hideQuestionButtonBar];
        [self hideQuestionLabel];
        [self hideAllItem];
    }
}
-(void)prevQuestion{
    if (questionIndex - 1 >= 0) {
        questionIndex--;
    }
    currentQuestion = questions[questionIndex];
    [self showQuestion];
}
-(void)showQuestion{
    self.questionLabel.text = currentQuestion.subject;
    self.questionLabel.frame = CGRectMake(self.questionLabel.frame.origin.x, self.questionLabel.frame.origin.y, 270, 0);
    self.questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.questionLabel.numberOfLines = 0;
    [self.questionLabel sizeToFit];
   
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(60-(self.questionLabel.numberOfLines-1)*20);
    [self.questionLabel.layer pop_addAnimation:animation forKey:@"adjustQuestionLabel"];
    
    if (questionImage != nil) {
        [questionImage removeFromSuperview];
        questionImage = nil;
    }
    optionYStart = 120.0f;
    if (![currentQuestion.imageName isEqualToString:@""]) {
        questionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:currentQuestion.imageName]];
        CGRect theRect = CGRectMake(30, optionYStart, questionImage.image.size.width, questionImage.image.size.height);
        questionImage.frame = theRect;
        [self.view addSubview:questionImage];
        optionYStart += questionImage.image.size.height + 10;
    }
    
    for (int i = 0; i < 4; i++) {
        OptionItem *item = [questionsItems objectAtIndex:i];
        if (i < currentQuestion.options.count) {
            OptionObject *option = currentQuestion.options[i];
            [item updateData:option];
        }else
        {
            [item updateData:nil];
        }
    }
    [NSTimer bk_performBlock:^{
        
        for (int i = 0; i < 4; i++) {
            OptionItem *item = [questionsItems objectAtIndex:i];
            POPSpringAnimation *animationAdaptY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            animationAdaptY.toValue = @(optionYStart + item.hTo/2);
            [item.layer pop_addAnimation:animationAdaptY forKey:@"animationAdaptY"];
            optionYStart += item.frame.size.height + 10;
        }
    } afterDelay:0.2];
}

- (IBAction)shareQuestion:(id)sender {
    [shareBar showMe];
    shareBar.messageToShare = currentQuestion.subject;
}
- (IBAction)shareResult:(id)sender {
    
}
- (IBAction)letMeTryAgain:(id)sender {
    if (winOnShow) {
        questionIndex = 0;
        currentQuestion = questions[questionIndex];
        [self hideWinAlert];
        [self hideWrongAnsewerButtonBar];
        [self showQuestionButtonBar];
        [self showQuestionLabel];
        [self showAllItem];
        [self showQuestion];
    }else
    {
        [self hideWinAlert];
        [self hideWrongAnsewerAlert];
        [self hideWrongAnsewerButtonBar];
        [self showQuestionButtonBar];
        [self showQuestionLabel];
        [self showAllItem];
    }
    
}

- (IBAction)backToMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)questionLabelTap:(id)sender {
    if ([currentQuestion.type isEqualToString:@"desc"]) {
        [self nextQuestion];
    }
}
@end
