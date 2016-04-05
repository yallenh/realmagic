//
//  Dog.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "Dog.h"
#import "Person.h"

@implementation Dog

// Specify default values for properties

- (NSArray *)owners {
    return [self linkingObjectsOfClass:@"Person" forProperty:@"dogs"];
}

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
