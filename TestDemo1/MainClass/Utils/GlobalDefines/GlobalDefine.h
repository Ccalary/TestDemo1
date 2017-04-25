//
//  GlobalDefine.h
//  TestDemo1
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

//大小尺寸
#define ScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                   ([[UIScreen mainScreen] bounds].size.height-64)

//屏幕适配
#define UIRate                          ScreenWidth/375.0

//rgb颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1.0]

//rgbA颜色（带透明度）
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

//hex颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//hexA颜色(带透明度)
#define HEXACOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

//font
#define FONT_SYSTEM(x)               [UIFont systemFontOfSize:x]
#define FONT_SYSTEM_BOLD(a)          [UIFont boldSystemFontOfSize:a]

 
//Debug信息
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s" " [行号:%d] " fmt),__FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#endif /* GlobalDefine_h */
