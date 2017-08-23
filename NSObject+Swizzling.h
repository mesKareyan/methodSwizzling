//
//  NSObject+Swizzling.h
//  NSURLSessionSwizzlingExample
//
//  Created by Mesrop Kareyan on 8/23/17.
//  Copyright © 2017 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)exchangeImplementationOfSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end
