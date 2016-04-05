//
//  RMNewsContent.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Realm/Realm.h>

@class RMNewsImage;
RLM_ARRAY_TYPE(RMNewsImage)

@interface RMNewsContent : RLMObject
@property NSString *uuid;
@property NSString *title;
@property NSString *type;
@property NSString *link;
@property NSInteger published_at;
@property NSInteger ts_update;
@property NSString *summary;
@property NSString *content;
@property NSString *category;
@property NSString *publisher;
@property RLMArray<RMNewsImage> *images;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<RMNewsContent>
// RLM_ARRAY_TYPE(RMNewsContent)
