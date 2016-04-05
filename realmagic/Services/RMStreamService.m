//
//  RMStreamService.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "RMStreamService.h"
#import "RMNewsContent.h"

static NSString *url = @"";

@implementation RMStreamService

+ (RMStreamService *)sharedInstance
{
    static RMStreamService *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RMStreamService alloc] init];
    });
    return _sharedInstance;
}

- (void)persistToDefaultRealm:(NSArray *)stream
{
    // Open the default Realm file
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];

    // Begin a write transaction to save to the default Realm
    [defaultRealm beginWriteTransaction];

    [stream enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Store the foursquare venue name and id in a Realm Object
        RMNewsContent *content = [[RMNewsContent alloc] initWithValue:obj];

        // Add the Venue object to the default Realm
        // (alternatively you could serialize the API response as an NSArray and call addObjectsFromArray)
        [defaultRealm addOrUpdateObject:content]; // update child?
    }];

    // Persist all the Venues with a single commit
    [defaultRealm commitWriteTransaction];
}

- (void)getPersistStreamCategory:(NSString *)category callback:(RMCallbackBlock)callback
{}

- (void)readCategory:(NSString *)category callback:(RMCallbackBlock)callback
{
    // 1. return persist
    NSString *query = [NSString stringWithFormat:@"category = '%@'", category];
    RLMResults<RMNewsContent *> *records = [RMNewsContent objectsWhere:query];
    NSLog(@"1. return persist: %d", [records count]);
    callback(nil, records);

    // 2. return api
    [[RMService sharedInstance] requestWithMethod:RMRequestMethodGet url:url params:nil callback:^(NSError *error, id result) {
        if (error) {
            NSLog(@"error: %@", error);
        } else {
            NSArray *stream = [((NSDictionary *)result) valueForKeyPath:@"items.result"];
            NSLog(@"2. return api: %d", [stream count]);
            callback(nil, stream);

            // 3. update realm
            [self persistToDefaultRealm:stream];
            NSLog(@"3. update realm: %d", [[RMNewsContent objectsWhere:query] count]);
        }
    }];
}

@end
