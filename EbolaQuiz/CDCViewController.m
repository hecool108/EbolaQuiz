//
//  CDCViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-12.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "CDCViewController.h"

@interface CDCViewController (){
    
    __weak IBOutlet UIWebView *webView;
}

@end

@implementation CDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cdc.gov"]]];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToQuiz:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
