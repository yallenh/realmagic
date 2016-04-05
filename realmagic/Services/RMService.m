//
//  RMService.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "RMService.h"
#import <AFHTTPSessionManager.h>

@implementation RMService

+ (RMService *)sharedInstance
{
    static RMService *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RMService alloc] init];
    });
    return _sharedInstance;
}

-(NSString *)_getValue:(id)obj
{
    return [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]] ?
        [[NSString stringWithFormat:@"%@",obj]
         stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]] : nil;
}
- (NSString *)urlString:(NSString *)urlStr WithParams:(NSDictionary *)params
{
    NSMutableString *queryString = [[NSMutableString alloc] initWithString:@""];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // for query string keys/values, encode all non-alphanumeric characters
        NSString *paramKey = [self _getValue:key];
        if (paramKey) {
            __block NSString *paramValue = [self _getValue:obj];
            if (paramValue) {
                [queryString appendFormat:@"%@=%@&", paramKey, paramValue];
            }
            else if ([obj isKindOfClass:[NSArray class]]) {
                [obj enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL *s) {
                    paramValue = [self _getValue:value];
                    if (paramValue) {
                        [queryString appendFormat:@"%@=%@&", paramKey, paramValue];
                    }
                }];
            }
            else {
                NSAssert(NO, @"%s -- query string value can only be either NSString or NSNumber or NSArray types",__PRETTY_FUNCTION__);
            }
        }
        else {
            NSAssert(NO, @"%s -- query string key can only be either NSString or NSNumber types",__PRETTY_FUNCTION__);
        }
    }];
    return [NSString stringWithFormat:@"%@?%@", urlStr, queryString];
}

- (void)requestWithMethod:(RMRequestMethod)method url:(NSString *)url params:(id)params callback:(RMCallbackBlock)callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    if (method == RMRequestMethodGet) {
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            callback(nil, responseObject);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            callback(nil, nil);
        }];
    }
    else if (method == RMRequestMethodPost)
    {}
    else if (method == RMRequestMethodUpdate)
    {}
    else if (method == RMRequestMethodDelete)
    {}
}

@end