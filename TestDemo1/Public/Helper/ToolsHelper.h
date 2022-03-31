//
//  ToolsHelper.h
//  Course
//
//  Created by caohouhong on 2019/4/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolsHelper : NSObject
/** 是否iPhoneX系列 */
+ (BOOL)isiPhoneX;
// 是否是iPhone
+ (BOOL)isiPhone;
// 是否是iPad
+ (BOOL)isiPad;
/** 检测改变过的文本是否匹配正则表达式 */
+(BOOL)isValid:(NSString*)checkStr withRegex:(NSString*)regex;
/** 检查是否拥有麦克风权限 */
+ (BOOL)canRecord;
/** Get IP Address */
+(NSString *)getIPAddress;
//年、月份、日期、时间 2019-03-04 12:08:08
+ (NSString *)getYYYYMMDDHHmmssFormateTime:(double)originTime;
//年、月份、日期、时间 2019-03-04 12:08
+ (NSString *)getYYYYMMDDHHmmFormateTime:(double)originTime;
/** 年、月份、日期 2019-03-12*/
+ (NSString *)getYYYYMMDDFormateTime:(double)originTime;
/** 月份和日期 03-12*/
+ (NSString *)getMMDDFormateTime:(double)originTime;
/** 时间分钟 13:00*/
+ (NSString *)getHHmmFormateTime:(double)originTime;

/** 根据日期获取周几 */
+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate;
/** 根据时间戳获取周几 */
+ (NSString *)weekdayStringFromTimestamp:(double)timestamp;
/** 计算时间差 */
+ (NSTimeInterval)compareDataWithCurrentTime:(NSString *)str;
/** 根据时间转化为距离现在多久时间格式为2019-12-14 14:57:46 */
+ (NSString *)compareCurrentTime:(NSString *)str;
// 根据时间转化为已过去多久（天）
+ (NSString *)compareDateWithCurrentTime:(NSString *)str;
/** 时间转化 HH:mm:ss -> HH:mm */
+ (NSString *)dealDataWithCurrentTime:(NSString *)str;
/** 将日期转成日期格式 */
+ (NSString *)getFormateDate:(NSDate *)date format:(NSString *)format;
/** 获取当前时间戳 */
+ (NSString *)getNowTimestamp;
/** 获取创建时间 */
+ (NSString *)getCreateTime;
/** 本地图片名称 */
+ (NSString *)createLocalImageNameKey;
/** 将日期格式转成日期 */
+ (NSDate *)getDateFromDateString:(NSString *)dateStr format:(NSString *)format;
//得到当前的时间 之前之后的日期 -1 前一年 1 后一年
+ (NSDate *)getNewTimeYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/** 得到当前时间相差几个月的日期 -1之前一个月 1之后一个月*/
+ (NSString *)getNewTimeWithMonth:(NSInteger)month;
/** 得到当前时间相差几天的日期 -1之前一天 1之后一天*/
+ (NSString *)getNewTimeWithDay:(NSInteger)day;
/** 得到当前时间相差几天的日期 format 自己定义 默认：yyyy-MM-dd */
+ (NSString *)getNewTimeWithDay:(NSInteger)day format:(NSString *)format;

/** 比较时间大小 -1(a < b),0(a=b),1(a>b) 默认yyyy-MM-dd HH:mm:ss */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
/** 比较时间大小 -1(a < b),0(a=b),1(a>b) format自定义 默认yyyy-MM-dd HH:mm:ss*/
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate format:(NSString *)format;
/** 比较某个时间和当前时间的大小 -1(a < b),0(a=b),1(a>b)*/
+ (NSInteger)compareWithNowDate:(NSString*)aDate;
/** 比较时间大小 -1(a < b),0(a=b),1(a>b) */
+ (NSComparisonResult)compareATime:(NSString*)aTime withBTime:(NSString*)bTime;
/**
 计算多行高度
 @param width 宽度
 @param font 字体大小
 @param string 内容
 @return 高度
 */
+ (CGFloat)calculateStringHeightWithWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string;

// 调整行间距
+ (NSMutableAttributedString *)changeLineSpaceWithStr:(NSString *)result lineSpacing:(CGFloat)spacing;
/** 调整行高 */
+ (NSMutableAttributedString *)changeLineHeightWithStr:(NSString *)result lineHeight:(CGFloat)height;
// 调整行间距加颜色
+ (NSMutableAttributedString *)changeLineSpaceAndColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString*>*)keyArray color:(UIColor *)color lineSpacing:(CGFloat)spacing;
/** 调整行高加颜色 */
+ (NSMutableAttributedString *)changeLineHeightAndColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString*>*)keyArray color:(UIColor *)color lineHeight:(CGFloat)height;
/** 调整首行缩进 */
+ (NSMutableAttributedString *)changeHeadSapceWithStr:(NSString *)result headSpacing:(CGFloat)headSpace;
/** 调整首行缩进、行间距 */
+ (NSMutableAttributedString *)changeLineSpaceAndHeadSapceWithStr:(NSString *)result lineSpacing:(CGFloat)spacing headSpacing:(CGFloat)headSpace;
/**改变字体颜色*/
+ (NSMutableAttributedString *)changeTextColorWithStr:(NSString *)result changeText:(NSString *)text color:(UIColor *)color;

/**更改多个字体颜色*/
+ (NSMutableAttributedString *)changeSomeTextColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString *>*)array color:(UIColor *)color;

/**改变字体大小*/
+ (NSMutableAttributedString *)changeTextSizeWithStr:(NSString *)result changeText:(NSString *)text font:(UIFont *)font;

/** 更改多个字体大小 */
+ (NSMutableAttributedString *)changeSomeTextSizeWithStr:(NSString *)result changeTextArray:(NSArray <NSString *>*)array font:(UIFont *)font;

/**找出要更改的字体数组*/
+ (NSArray *)checkChangeArrayWitStr:(NSString *)result andMarkStr:(NSString *)markStr;

/**改变字体颜色和大小*/
+ (NSMutableAttributedString *)changeTextFontColorWithStr:(NSString *)result changeText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

/** 封装的保留两位的逗号分隔方法 */
+ (NSString *)changeMoneyPositiveFormat:(NSString *)text;
/** 手机号加星号 */
+ (NSString *)phoneNumberAddSymbols:(NSString *)number;

/** 数组或字典转json */
+ (NSString *)arrayOrDictionaryToJsonString:(id)obj;
/** 数组字典转json并去除转义字符 */
+ (NSString *)arrayOrDictionaryToJsonStringClearEscapeCharacter:(id)obj;
/** 将JSON串转化为数组 */
+ (NSArray *)jsonToArray:(NSString *)json;
/** 将JSON串转化为字典 */
+ (NSDictionary *)jsonToDictionary:(NSString *)json;
/** 获取当前屏幕显示的viewcontroller */
+ (UIViewController *)getCurrentVC;
/** 去除某些字，获取天气的时候不需要 */
+ (NSString *)removeSomeCityText:(NSString *)cityName;
/** 圆圈背景获取不同背景色 */
+ (UIColor *)backgroundColorWithIndex:(NSInteger)index;
/** 压缩图片 */
+(void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB image:(UIImage *)image Block :(void (^)(NSData *imageData))block;
/** 压缩图片 */
+ (UIImage *)compressImage:(UIImage *)image toKB:(NSUInteger)maxLength;
/**合并图片 第二张图在第一张中心 */
+ (UIImage *)combine:(UIImage *)oneImage otherImage:(UIImage *)otherImage;
/** 更改图片大小 */
+ (UIImage *)changeImage:(UIImage*)image byScalingToSize:(CGSize)targetSize;
/** 获取图片第一帧 */
+ (UIImage*)getVideoPreViewImage:(NSURL *)url;
/**
 * 截取图片
 * @param theView 要截图的View
 * @param scale 缩放比例 设置为0会自动获取系统缩放因子[UIScreen mainScreen].scale
 * @param maxLength 压缩大小 如果为0，默认不压缩
 */
+ (UIImage *)screenImageFromView:(UIView *)theView scale:(CGFloat )scale compressToKB:(NSUInteger)maxLength;

/**
* 截取图片 特殊处理 openGL 不规则形状截取方案
* @param theView 要截图的View
* @param scale 缩放比例 设置为0会自动获取系统缩放因子[UIScreen mainScreen].scale
* @param maxLength 压缩大小 如果为0，默认不压缩
* @param isAfter yes-会在数据加载后截取 no-直接截取
*/
+ (UIImage *)screenUpdateImageFromView:(UIView *)theView scale:(CGFloat )scale compressToKB:(NSUInteger)maxLength afterScreenUpdates:(BOOL)isAfter;

/**
 * 截取tableView和scrollView 长图，tableview初始化要用基础的frame初始化，自动布局有问题会截取不全
 */
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
