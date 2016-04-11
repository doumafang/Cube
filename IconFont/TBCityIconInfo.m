//
//  TBCityFontImageInfo.m
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import "TBCityIconInfo.h"

@implementation TBCityIconInfo

- (instancetype)initWithText:(NSString *)text size:(CGFloat)sizeF color:(UIColor *)color {
    if (self = [super init]) {
        self.text = text;
        self.sizeF = sizeF;
        self.color = color;
    }
    return self;
}

+ (instancetype)iconInfoWithText:(NSString *)text size:(CGFloat)sizeF color:(UIColor *)color {
    return [[TBCityIconInfo alloc] initWithText:text size:sizeF color:color];
}

@end
