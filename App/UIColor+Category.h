//
//  UIColor+Category.h
//  AppIOS
//
//  Created by Pat Murphy on 5/17/14.
//  Copyright (c) 2014 Fitamatic All rights reserved.
//
//  Info : Category to extend NSString with some handy methods.
//

#import <Foundation/Foundation.h>

@interface UIColor (Category)

+(UIColor*)colorWithHexRGB:(NSString*)hexRGB AndAlpha:(float)alpha;
+(NSString*)getHexColor:(UIColor*)color;
+(UIColor*) getColorFrom:(UIColor*)inputColor add:(CGFloat)addValue;
+(UIColor *)colorWithWebColor:(NSInteger)rgbValue;
+(UIColor *)colorWithWebColorString:(NSString *)hexColor;

@end

