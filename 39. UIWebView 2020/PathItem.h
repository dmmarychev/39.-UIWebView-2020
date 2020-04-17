//
//  PathItem.h
//  39. UIWebView 2020
//
//  Created by Dmitry Marchenko on 4/17/20.
//  Copyright © 2020 Dmitry Marchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PathItemTypePDF,
    PathItemTypeWebPage
} PathItemType;

@interface PathItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *iconName;
@property (assign, nonatomic) PathItemType type;

@end

NS_ASSUME_NONNULL_END
