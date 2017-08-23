//
//  NSURLSession+Tracking.m
//  NSURLSessionSwizzlingExample
//
//  Created by Mesrop Kareyan on 8/23/17.
//  Copyright © 2017 none. All rights reserved.
//

#import "NSURLSession+Tracking.h"
#import "NSObject+Swizzling.h"

typedef void (^NSENSURLSessionCompletion)(NSData *, NSURLResponse *, NSError *);

@implementation NSURLSession (NSETracking)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeImplementationOfSelector:@selector(dataTaskWithRequest:)
                                  withSelector:@selector(nse_dataTaskWithRequest:)];
        
        [self exchangeImplementationOfSelector:@selector(dataTaskWithRequest:completionHandler:)
                                  withSelector:@selector(nse_dataTaskWithRequest:completionHandler:)];
        
        [self exchangeImplementationOfSelector:@selector(dataTaskWithURL:)
                                  withSelector:@selector(nse_dataTaskWithURL:)];
        
        [self exchangeImplementationOfSelector:@selector(dataTaskWithURL:completionHandler:)
                                  withSelector:@selector(nse_dataTaskWithURL:completionHandler:)];
        
    });
    
}


#pragma mark - Method Swizzling

- (NSURLSessionDataTask *)nse_dataTaskWithRequest:(NSURLRequest *)request {
    
    NSURLSessionDataTask *dataTask = [self nse_dataTaskWithRequest: request];
    NSLog(@"\n +++%@ \n",  NSStringFromSelector(_cmd));
    return dataTask;
    
}

- (NSURLSessionDataTask *)nse_dataTaskWithRequest:(NSURLRequest *)request
                                completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    
    NSDate *date = [NSDate date];
    NSURLSessionDataTask *dataTask =
    [self nse_dataTaskWithRequest:request
                completionHandler: ^(NSData *data, NSURLResponse *respone, NSError *error){
                    
                    NSTimeInterval  time = fabs([date timeIntervalSinceNow]);
                    NSLog(@" \n\n+++\n\"%@\"\n %.2f Kb,\n %.2f seconds\n+++\n\n",
                          request.URL,
                          (unsigned long)data.length / 1024.0,
                          time);
                    
                    if (completionHandler) {
                        completionHandler(data, respone, error);
                    }
                    
                }];
    
    return dataTask;
    
}

- (NSURLSessionDataTask *)nse_dataTaskWithURL:(NSURL *)url {
    
    NSURLSessionDataTask *dataTask = [self nse_dataTaskWithURL: url];
    NSLog(@" \n +++%@ \n",  NSStringFromSelector(_cmd));
    return dataTask;
    
}

- (NSURLSessionDataTask *)nse_dataTaskWithURL:(NSURL *)url
                            completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    
    NSURLSessionDataTask *task =
    [self nse_dataTaskWithURL: url completionHandler:completionHandler];
    
    return task;
    
}


@end
