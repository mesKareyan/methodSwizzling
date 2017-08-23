//
//  NSObject+Swizzling.m
//  NSURLSessionSwizzlingExample
//
//  Created by Mesrop Kareyan on 8/23/17.
//  Copyright © 2017 none. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)exchangeImplementationOfSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
