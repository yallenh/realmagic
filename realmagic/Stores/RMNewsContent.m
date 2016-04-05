//
//  RMNewsContent.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "RMNewsContent.h"
#import "RMNewsImage.h"

@implementation RMNewsContent

+ (NSString *)primaryKey
{
    return @"uuid";
}

- (instancetype)initWithValue:(id)value
{
    self = [super init];
    if (self) {
        self.uuid = [value objectForKey:@"uuid"];
        self.title = [value objectForKey:@"title"];
        self.type = [value objectForKey:@"type"];
        self.link = [value objectForKey:@"link"];
        self.summary = [value objectForKey:@"summary"];
        self.content = [value objectForKey:@"content"];
        self.category = [value objectForKey:@"category"];
        self.publisher = [value objectForKey:@"publisher"];
        self.published_at = [[value objectForKey:@"published_at"] integerValue];
        self.ts_update = [[value objectForKey:@"ts_update"] integerValue];

        NSMutableArray *imagesModel = [[NSMutableArray alloc] init];
        [[value valueForKeyPath:@"main_image.resolutions"]
         enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [imagesModel addObject:[[RMNewsImage alloc] initWithValue:obj]];
        }];
        [self.images addObjects:imagesModel];
    }
    return self;
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)
/*
+ (NSArray *)ignoredProperties
{
    return @[@"main_image"];
}
*/
@end
