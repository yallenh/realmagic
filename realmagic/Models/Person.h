//
//  Person.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@class Dog;

@interface Person : RLMObject
@property NSString *name;
@property RLMArray<Dog *><Dog> *dogs;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Person>
RLM_ARRAY_TYPE(Person)
