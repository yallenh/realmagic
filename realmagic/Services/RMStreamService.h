//
//  RMStreamService.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMService.h"

@interface RMStreamService : NSObject

/**
 * singleton
 */
+ (RMStreamService *)sharedInstance;

/**
 * @param category Stream category
 */
- (void)readCategory:(NSString *)category callback:(RMCallbackBlock)callback;

@end
