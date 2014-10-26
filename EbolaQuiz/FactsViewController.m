//
//  FactsViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/20.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "FactsViewController.h"
#import "SingleFactViewController.h"
#import "TFHpple.h"
#import "Pop.h"
#import "BlocksKit.h"
#import "ShareBar.h"
#import "VirusGenerator.h"
#import "FactObject.h"
@interface FactsViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>{
    NSMutableArray *facts;
    NSMutableArray *pageContentViews;
    FactObject *currentFact;
    ShareBar *shareBar;
    VirusGenerator *virusGenerator;
    UIPageViewController *pageViewController;
    SingleFactViewController *currentView;
}
@end

@implementation FactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect theFrame = self.shareButton.frame;
//    theFrame.origin.y = self.view.frame.size.height - 65 - 10;
//    self.shareButton.frame = theFrame;
    facts = [NSMutableArray array];
    NSError *error;
    NSString *str=[[NSBundle mainBundle] pathForResource:@"facts" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:str options:NSDataReadingMapped error:&error];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements  = [doc searchWithXPathQuery:@"//fact"];
    for (int i = 0; i < elements.count; i++) {
        TFHppleElement *ele = elements[i];
        [facts addObject:[[FactObject alloc] initWithTFHppleElement:ele]];
    }
    shareBar = [[ShareBar alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    shareBar.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 80);
    shareBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    shareBar.screenH = self.view.frame.size.height;
    shareBar.mode = ShareBarModeQuestion;
    [self.view addSubview:shareBar];
    [self initFactPages];
    virusGenerator = [[VirusGenerator alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:virusGenerator atIndex:0];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [virusGenerator initVirusNumbers:8 + arc4random_uniform(5)];
}
-(void)initFactPages{
    pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EQPageViewController"];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
//    pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    pageContentViews = [NSMutableArray array];
    [pageViewController.childViewControllerForStatusBarHidden.view setHidden:YES];
    SingleFactViewController *pageContent;
    long daCount = facts.count;
    for (int i = 0; i < daCount; i++) {
        FactObject *da = facts[i];
        pageContent = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleFactViewController"];
        pageContent.factData = da;
        pageContent.pageIndex = i;
        [pageContentViews addObject:pageContent];
    }
    NSUInteger currentIndex = 0;
    currentView = pageContentViews[currentIndex];
    [pageViewController setViewControllers:@[currentView]
                                 direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:pageViewController];
    [self.view insertSubview:pageViewController.view atIndex:0];
    [pageViewController didMoveToParentViewController:self];
    pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
}




- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    NSLog(@"%zd",pageContentViews.count);
    return pageContentViews.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [(SingleFactViewController *)viewController pageIndex];
    if (currentIndex == 0) {
        return nil;
    }
    currentIndex--;
    return [pageContentViews objectAtIndex:currentIndex];
    
}
//
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [(SingleFactViewController *)viewController pageIndex];
    currentIndex++;
    if (currentIndex == pageContentViews.count) {
        return nil;
    }
    return [pageContentViews objectAtIndex:currentIndex];
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{

}
- (IBAction)shareFact:(id)sender {
    shareBar.messageToShare = currentFact.subject;
    [shareBar showMe];
}

- (IBAction)backToMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
