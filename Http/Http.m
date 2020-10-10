//
//  Http.m
//  Http
//
//  Created by HaoHuoBan on 2020/9/28.
//  Copyright © 2020 HaoHuoBan. All rights reserved.
//

#import "Http.h"

#define BASEURL @"http://192.168.1.170:7000"
#define HTTPTIMEOUT 30

#import "BaseModel.h"
@interface NetModel : BaseModel
@property (nonatomic, assign) BOOL animation;
@property (nonatomic, assign) BOOL token;
@end
@implementation NetModel
@end

@implementation Http

#pragma mark -----外部方法

+ (void)post:(NSDictionary *)param url:(NSString *)url callback:(nonnull HttpCallback)callback {
    [self post:param url:url config:nil callback:callback];
}

+ (void)get:(NSDictionary *)param url:(NSString *)url callback:(nonnull HttpCallback)callback {
    [self get:param url:url config:nil callback:callback];
}

+ (void)post:(NSDictionary *)param url:(NSString *)url config:(NSDictionary *)config callback:(nonnull HttpCallback)callback {
    NSMutableURLRequest *request = [self makeRequest:param url:url config:config];
    [request setHTTPMethod:@"POST"];
    [self sendRequest:request callback:callback];
}

+ (void)get:(NSDictionary *)param url:(NSString *)url config:(NSDictionary *)config callback:(nonnull HttpCallback)callback {
    NSMutableURLRequest *request = [self makeRequest:param url:url config:config];
    [request setHTTPMethod:@"GET"];
    [self sendRequest:request callback:callback];
}

#pragma mark -----内部方法

+ (void)sendRequest:(NSMutableURLRequest *)request callback:(HttpCallback)callback {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (data && (error == nil)) {
        NSLog(@"-----ceshi:data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          if (callback) {
              dispatch_async(dispatch_get_main_queue(), ^{ callback(data); });
          }
      } else {
        NSLog(@"-----ceshi:error=%@",error);
      }
    }];
    [dataTask resume];
}

+ (NetModel *)handleDefaultConfig:(NSDictionary *)config {
    
    NSMutableDictionary *model = @{
        @"animation":@(YES),
        @"token":@(YES)
    }.mutableCopy;
    
    if (config) {
        for (NSString *key in config) {
            if (config[key]) {
                model[key] = config[key];
            }
        }
    }
    NetModel *m = [[NetModel alloc] initWithDictionary:model];
    return m;
}

+ (NSString *)getAppToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token_ios"];
    return token;
}

+ (NSMutableURLRequest *)makeRequest:(NSDictionary *)param url:(NSString *)url config:(NSDictionary *)config {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *temp_URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:temp_URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:HTTPTIMEOUT];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //处理参数
    NetModel *m = [self handleDefaultConfig:config];
    if (m.token) {
        NSString *token = [self getAppToken];
        NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
        [request addValue:value forHTTPHeaderField:@"Authorization"];
    }
    NSError *error;
    NSData *body = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingFragmentsAllowed error:&error];
    if (error) {
        NSLog(@"请求参数转化出错(error), = %@",error);
        NSLog(@"请求参数转化出错(url), = %@",url);
        return request;
    }
    [request setHTTPBody:body];
//    [request setHTTPMethod:@"POST"];
    return request;
}

@end
