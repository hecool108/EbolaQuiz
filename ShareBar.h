//
//  ShareBar.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-17.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
typedef NS_ENUM(NSUInteger, ShareBarMode) {
    ShareBarModeApp,
    ShareBarModeQuestion,
};
@interface ShareBar : UIView <FBLoginViewDelegate>
@property(assign)float screenH;
@property(assign)ShareBarMode mode;
@property(nonatomic)NSString *messageToShare;
- (void)showMe;
@end
