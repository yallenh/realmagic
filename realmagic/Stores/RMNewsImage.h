//
//  RMNewsImage.h
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/5/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import <Realm/Realm.h>

@interface RMNewsImage : RLMObject
@property NSString *url;
@property NSInteger height;
@property NSInteger width;
@property NSString *tag;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<RMNewsImage>
// RLM_ARRAY_TYPE(RMNewsImage)
