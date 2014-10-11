//
//  QuestionObject.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QuestionObject : NSManagedObject

@property (nonatomic, retain) id answers;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSSet *options;
@end

@interface QuestionObject (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(NSManagedObject *)value;
- (void)removeOptionsObject:(NSManagedObject *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
