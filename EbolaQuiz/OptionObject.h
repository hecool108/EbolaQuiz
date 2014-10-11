//
//  OptionObject.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionObject;

@interface OptionObject : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * statement;
@property (nonatomic, retain) QuestionObject *questionBelongsTo;

@end
