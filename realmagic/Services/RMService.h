//
//  RMService.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * HTTP request methods
 */
typedef NS_ENUM(NSInteger, RMRequestMethod) {
    RMRequestMethodGet,
    RMRequestMethodPost,
    RMRequestMethodUpdate,
    RMRequestMethodDelete
};


/**
 * general callback block
 */
typedef void (^RMCallbackBlock)(NSError *error, id result);


@interface RMService : NSObject

/**
 * singleton
 */
+ (RMService *)sharedInstance;

/**
 * @param params Key-value pairs query params, value can be NSString, NSNumber or NSArray
 */
- (NSString *)urlString:(NSString *)urlStr WithParams:(NSDictionary *)params;

/**
 * @param method
 * @param urlStr Query params should already be appended
 * @param params Types either NSObject or NSArray
 */
- (void)requestWithMethod:(RMRequestMethod)method url:(NSString *)url params:(id)params callback:(RMCallbackBlock)callback;

@end
