//
//  UIImage+Iconfont.swift
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/10.
//  Copyright © 2016年 doumafang. All rights reserved.
//

import Foundation
import CoreText
import UIKit

extension UIImage{
    
//    func iconWithInfo(info : TBCityIconInfo) -> UIImage {
//
//        let size : CGFloat = info.sizeF
//        let scale : CGFloat = UIScreen.mainScreen().scale
//        let realSize : CGFloat = size * scale
//        
//        var font :UIFont = TBCityIconFont.fontWithSize(realSize)
//        UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
//        var context:CGContextRef = UIGraphicsGetCurrentContext()!;
//        
//        let textFontAttributes = [
//            NSFontAttributeName: font,
//            NSForegroundColorAttributeName: info.color
//        ]
//        
////        if (info.text(respondsToSelector(Selector("drawAtPoint: withAttributes: ")))) {
//        
//            info.text(drawAtPoint(CGPointZero, withAttributes: textFontAttributes))
//            
////        }
//        
//        
//        
//        UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
//        UIGraphicsEndImageContext();
//    
//        return image;
//    }
    
    
//    + (UIImage *)iconWithInfo:(TBCityIconInfo *)info {
//    CGFloat size = info.size;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    CGFloat realSize = size * scale;
//    UIFont *font = [TBCityIconFont fontWithSize:realSize];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    if ([info.text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
//    /**
//     * 如果这里抛出异常，请打开断点列表，右击All Exceptions -> Edit Breakpoint -> All修改为Objective-C
//     * See: http://stackoverflow.com/questions/1163981/how-to-add-a-breakpoint-to-objc-exception-throw/14767076#14767076
//     */
//    [info.text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: info.color}];
//    } else {
//    
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    CGContextSetFillColorWithColor(context, info.color.CGColor);
//    [info.text drawAtPoint:CGPointMake(0, 0) withFont:font];
//    #pragma clang pop
//    }
//    
//    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
//    UIGraphicsEndImageContext();
//    
//    return image;
//    }

    
    
    
}
