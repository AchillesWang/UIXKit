//
//  UIXHelper.h
//  UIXKiy
//
//  Created by 汪潇翔 on 14-4-21.
//  Copyright (c) 2014年 JiaYuan. All rights reserved.
//

//#ifndef UIXKiy_UIXHelper_h
//#define UIXKiy_UIXHelper_h
//
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

static inline CGRect UIXCenterCGSizeInCGRect(CGSize innerRectSize,CGRect outerRect){
    CGRect innerRect;
    innerRect.size = innerRectSize;
    innerRect.origin.x = outerRect.origin.x + (outerRect.size.width  - innerRectSize.width)  / 2.0f;
    innerRect.origin.y = outerRect.origin.y + (outerRect.size.height - innerRectSize.height) / 2.0f;
    return innerRect;
}
//#endif
