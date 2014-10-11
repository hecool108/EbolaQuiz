//
//  AppDelegate.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-9.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreData+MagicalRecord.h"
#import "OptionObject.h"
#import "QuestionObject.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"EbolaQuiz.sqlite"];
    
    QuestionObject *question = [QuestionObject MR_findFirst];
    NSLog(@"Question '%@' have %zd options",question.subject,question.options.count);
    
    [question MR_deleteEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %d ",1];
    NSArray *datas = [QuestionObject MR_findAllSortedBy:@"id" ascending:YES withPredicate:predicate];
    NSLog(@"There are %zd questions with id == 1",datas.count);
    
    
//    QuestionObject *question = [QuestionObject MR_createEntity];
//    question.id = @"1";
//    question.subject = @"This is a question.";
//    question.desc = @"Yes it is just a question.";
//    
//    OptionObject *option = [OptionObject MR_createEntity];
//    option.id = @"1-1";
//    option.statement = @"Option A";
//    
//    option.questionBelongsTo = question;
//    [question addOptionsObject:option];
    
    [self save];
    
    return YES;
}
- (void)save {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
