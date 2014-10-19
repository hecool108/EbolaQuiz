//
//  ShareBar.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-17.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "ShareBar.h"
#import "Pop.h"
#import <FacebookSDK/FacebookSDK.h>
@interface ShareBar(){
    FBLoginView *faceBookLoginButton;
    UIButton *faceBookShareButton;
    UIButton *twitterShareButton;
}
@end
@implementation ShareBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initShareButtons];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.backgroundColor = [UIColor whiteColor];
        [closeButton setTitle:@"关  闭" forState:UIControlStateNormal];
        closeButton.frame = CGRectMake(51, 108.5, 218, 46);
        [closeButton addTarget:self action:@selector(closeMe:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
    }
    return self;
}
- (void)initShareButtons
{
    if (faceBookShareButton) {
        [faceBookShareButton removeFromSuperview];
        faceBookShareButton = nil;
    }
    if (faceBookLoginButton) {
        [faceBookLoginButton removeFromSuperview];
        faceBookLoginButton.delegate = nil;
        faceBookLoginButton = nil;
    }
    if ([FBSession activeSession].isOpen) {
        faceBookShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        faceBookShareButton.frame = CGRectMake(0, 0, 218, 46);
        [faceBookShareButton setBackgroundImage:[UIImage imageNamed:@"shareButton"] forState:UIControlStateNormal];
        faceBookShareButton.center = CGPointMake(self.center.x, 9+23);
        [faceBookShareButton addTarget:self action:@selector(shareToFaceBook:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:faceBookShareButton];
    }else
    {
        faceBookLoginButton = [[FBLoginView alloc] init];
        faceBookLoginButton.delegate = self;
        faceBookLoginButton.center = CGPointMake(self.center.x, 9+23);
        [self addSubview:faceBookLoginButton];
    }
    if (twitterShareButton == nil) {
        twitterShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        twitterShareButton.frame = CGRectMake(0, 0, 218, 46);
        [twitterShareButton setBackgroundImage:[UIImage imageNamed:@"shareTwitterButton"] forState:UIControlStateNormal];
        twitterShareButton.center = CGPointMake(self.center.x, 9+23+46+3);
        [twitterShareButton addTarget:self action:@selector(shareToTwitter:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:twitterShareButton];
    }
    
}
- (void)shareToTwitter:(id)sender{
    NSString *stringURL = @"twitter://post?message=If%20you%20want%20to%20know%20facts%20about%20Ebola%2C%20Search%20EbolaQuiz%20in%20App%20Store&imageURL";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)shareToFaceBook:(id)sender{
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    params.name = @"Ebola Quiz";
    params.caption = @"Ebola Quiz";
    params.picture = [NSURL URLWithString:@"http://hecool108.qiniudn.com/Icon-60%402x.png"];
    if (self.mode == ShareBarModeApp) {
        params.linkDescription = @"Know facts about Ebola.";
    }else
    {
        params.linkDescription = self.messageToShare;
    }
    
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        [FBDialogs presentShareDialogWithLink:params.link
                                         name:params.name
                                      caption:params.caption
                                  description:params.linkDescription
                                      picture:params.picture
                                  clientState:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
    } else {
        // Present the feed dialog
    }
}
#pragma mark facebook delegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    if ([FBSession activeSession].isOpen) {
        [self initShareButtons];
    }
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user{
    if ([FBSession activeSession].isOpen) {
        [self initShareButtons];
    }
}
- (void)showMe{
    POPSpringAnimation *showShareBarAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    showShareBarAnimation.toValue = @(self.screenH - 80);
    [self.layer pop_addAnimation:showShareBarAnimation forKey:@"showShareBarAnimation"];
}
- (void)closeMe:(id)sender{
    POPSpringAnimation *closeShareBarAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    closeShareBarAnimation.toValue = @(self.screenH + 80);
    [self.layer pop_addAnimation:closeShareBarAnimation forKey:@"closeShareBarAnimation"];
}
@end
