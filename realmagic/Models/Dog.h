//
//  Dog.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Realm/Realm.h>

@class Person;

@interface Dog : RLMObject
@property NSString *name;
@property NSInteger age;
@property (readonly) NSArray *owners;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Dog>
RLM_ARRAY_TYPE(Dog)
