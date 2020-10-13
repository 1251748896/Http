//
//  Http.h
//  Http
//
//  Created by HaoHuoBan on 2020/9/28.
//  Copyright © 2020 HaoHuoBan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HttpCallback)(id);

@interface Http : NSObject

+ (void)post:(NSDictionary *)param url:(NSString *)url callback:(HttpCallback)callback;
+ (void)get:(NSDictionary *)param url:(NSString *)url callback:(HttpCallback)callback;
+ (void)get:(NSDictionary *)param allUrl:(NSString *)url callback:(HttpCallback)callback;
+ (void)post:(NSDictionary *)param url:(NSString *)url config:(nullable NSDictionary *)config callback:(HttpCallback)callback;
+ (void)get:(NSDictionary *)param url:(NSString *)url config:(nullable NSDictionary *)config callback:(HttpCallback)callback;
@end

NS_ASSUME_NONNULL_END
