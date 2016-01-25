
//
//  NSString+Extension.m
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(BOOL)isContainSubstring:(NSString *)subString{
    NSRange range = [[self lowercaseString] rangeOfString:[subString lowercaseString]];
    return (range.location != NSNotFound);
}

//#pragma message "Ignoring designated initializer warnings"



#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

-(NSString *)initPhoneString{// Convenience initialzer  missing  a self call to another initializer

    if ([self isContainSubstring:@"-"]) {//
        self = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([self isContainSubstring:@" "])
    {
        self = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([self isContainSubstring:@"("])
    {
        self = [self stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([self isContainSubstring:@")"])
    {
        self = [self stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    return self;
}
-(NSString *)getFirstCharactor{
    NSMutableString * pinyin = [[NSMutableString alloc] initWithString:self];
    if (CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformMandarinLatin, NO)) {
        
    }
    if (CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformStripDiacritics, NO)) {
    }
    return [pinyin substringToIndex:1];
}


@end
