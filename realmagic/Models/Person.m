//
//  Person.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "Person.h"
#import "Dog.h"

@implementation Person

// Specify default values for properties

+ (NSString *)primaryKey
{
    return @"name";
}

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
