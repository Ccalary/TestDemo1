//
//  ToolsHelper.m
//  Course
//
//  Created by caohouhong on 2019/4/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import "ToolsHelper.h"
#import "sys/utsname.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <AVFoundation/AVFoundation.h>

@implementation ToolsHelper
//手机型号
//记得导入#import "sys/utsname.h"
+ (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    return deviceString;
}

// 是否是iPhone
+ (BOOL)isiPhone {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

// 是否是iPad
+ (BOOL)isiPad {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
+(BOOL)isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}

//检查是否拥有麦克风权限
+ (BOOL)canRecord {
    __block BOOL bCanRecord = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            } else {
                bCanRecord = NO;
            }
        }];
    }
    return bCanRecord;
}

+ (BOOL)isiPhoneX {
    // 状态栏高度大于20，则是刘海屏幕，否则是普通屏幕
    return (StatusBarHeight > 20.0f);
}

// Get IP Address
+(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                NSString *ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                
                NSString* getedAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                NSString* mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
                NSString* gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
                
                NSLog(@"ifaName:%@--address:%@--mask:%@--gateway:%@",ifaName,address,mask,gateway);
                
                if([ifaName isEqualToString:@"en0"]) {//无线网
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }else if([ifaName isEqualToString:@"pdp_ip0"]){//3g、4g网
                    address = getedAddress;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//年、月份、日期、时间
+ (NSString *)getYYYYMMDDHHmmssFormateTime:(double)originTime
{
    return [self getFormateTime:originTime format:@"yyyy-MM-dd HH:mm:ss"];
}

//年、月份、日期、时间
+ (NSString *)getYYYYMMDDHHmmFormateTime:(double)originTime
{
    return [self getFormateTime:originTime format:@"yyyy-MM-dd HH:mm"];
}


//年、月份、日期
+ (NSString *)getYYYYMMDDFormateTime:(double)originTime
{
    return [self getFormateTime:originTime format:@"yyyy-MM-dd"];
}

//月份和日期
+ (NSString *)getMMDDFormateTime:(double)originTime
{
    return [self getFormateTime:originTime format:@"MM-dd"];
}

// 时间分钟
+ (NSString *)getHHmmFormateTime:(double)originTime
{
    return [self getFormateTime:originTime format:@"HH:mm"];
}

//将时间戳转成日期格式
+ (NSString *)getFormateTime:(double)originTime format:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];//yyyy.MM.dd HH:mm:ss
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:originTime];
    return [formatter stringFromDate:date];
}

//将日期转成日期格式
+ (NSString *)getFormateDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];//yyyy.MM.dd HH:mm:ss
    return [formatter stringFromDate:date];
}

//获取当前时间戳
+ (NSString *)getNowTimestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval stamp = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",stamp];
    return timeString;
}

//本地图片名称
+ (NSString *)createLocalImageNameKey
{
    NSString *stamp = [self getNowTimestamp];
    int random = arc4random()%1000000;
    NSString *timeString = [NSString stringWithFormat:@"%@%d", stamp, random];
    return timeString;
}

//获取创建时间
+ (NSString *)getCreateTime
{
    return [self getFormateDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
}

//将日期格式转成日期
+ (NSDate *)getDateFromDateString:(NSString *)dateStr format:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];//yyyy.MM.dd HH:mm:ss
    return [formatter dateFromString:dateStr];
}

// 得到当前时间相差几个月的日期
+ (NSString *)getNewTimeWithMonth:(NSInteger)month {
    NSDate *date = [self getNewTimeYear:0 month:month day:0];
    return [self getFormateDate:date format:@"yyyy-MM-dd"];
}

// 得到当前时间相差几天的日期
+ (NSString *)getNewTimeWithDay:(NSInteger)day {
    return [self getNewTimeWithDay:day format:@""];
}

// 得到当前时间相差几天的日期 format 自己定义 yyyy-MM-dd
+ (NSString *)getNewTimeWithDay:(NSInteger)day format:(NSString *)format{
    NSDate *date = [self getNewTimeYear:0 month:0 day:day];
    if (format.length > 0){
        return [self getFormateDate:date format:format];
    }else {
       return [self getFormateDate:date format:@"yyyy-MM-dd"];;
    }
}

//得到当前的时间 之前之后的日期 -1 前一年 1 后一年
+ (NSDate *)getNewTimeYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];//-1 前一年 1 后一年
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
    return newdate;
}

//根据日期获取周几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = @[@"",@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

//根据时间戳获取周几
+ (NSString*)weekdayStringFromTimestamp:(double)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [self weekdayStringFromDate:date];
}

// 计算时间差
+ (NSTimeInterval)compareDataWithCurrentTime:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差 秒
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    return timeInterval;
}

// 时间转化 HH:mm:ss -> HH:mm
+ (NSString *)dealDataWithCurrentTime:(NSString *)str {
    if (str.length == 0) return str;
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    return [self getFormateDate:timeDate format:@"yyyy.MM.dd HH:mm"];
}

// 根据时间转化为距离现在多久
+ (NSString *)compareCurrentTime:(NSString *)str{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        result = [dateFormatter stringFromDate:timeDate];
    }
    return  result;
}

// 根据时间转化为已过去多久（天）
+ (NSString *)compareDateWithCurrentTime:(NSString *)str{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if((timeInterval/60/60) < 12){
        result = @"0天";
    }else if((timeInterval/60/60) < 24){
        result = @"0.5天";
    }else{
        temp = timeInterval/60/60/24;
        result = [NSString stringWithFormat:@"%ld天",temp];
    }
    return  result;
}


// 比较时间大小 -1(a < b),0(a=b),1(a>b)
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame){
        //相等
        aa = 0;
    }else if (result==NSOrderedAscending) {
        //bDate比aDate大
        aa = -1;
    }else if (result==NSOrderedDescending) {
        //bDate比aDate小
        aa = 1;
    }
    return aa;
}

// 比较时间大小 -1(a < b),0(a=b),1(a>b)
+ (NSComparisonResult)compareATime:(NSString*)aTime withBTime:(NSString*)bTime
{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aTime];
    dtb = [dateformater dateFromString:bTime];
    NSComparisonResult result = [dta compare:dtb];
    return result;
}

// 比较时间大小 -1(a < b),0(a=b),1(a>b)
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate format:(NSString *)format {
    NSInteger aa = 0;
    if (format.length == 0){
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:format];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame){
        //相等
        aa = 0;
    }else if (result==NSOrderedAscending) {// 升序
        //bDate比aDate大
        aa = -1;
    }else if (result==NSOrderedDescending) {// 降序
        //bDate比aDate小
        aa = 1;
    }
    return aa;
}
/** 比较某个时间和当前时间的大小 -1(a < b),0(a=b),1(a>b)*/
+ (NSInteger)compareWithNowDate:(NSString*)aDate {
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    dta = [dateformater dateFromString:aDate];
    
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame){
        //相等
        aa = 0;
    }else if (result==NSOrderedAscending) {
        //bDate比aDate大
        aa = -1;
    }else if (result==NSOrderedDescending) {
        //bDate比aDate小
        aa = 1;
    }
    return aa;
}

//计算多行高度
+ (CGFloat )calculateStringHeightWithWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

// 调整行间距
+ (NSMutableAttributedString *)changeLineSpaceWithStr:(NSString *)result lineSpacing:(CGFloat)spacing{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing]; //调整行间距
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    return attributeStr;
}

// 调整行间距加颜色
+ (NSMutableAttributedString *)changeLineSpaceAndColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString*>*)keyArray color:(UIColor *)color lineSpacing:(CGFloat)spacing{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing]; //调整行间距
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:result];
    // 去重
    for (NSString *keyStr in keyArray){
        NSRange colorRange = NSMakeRange([[tempStr string] rangeOfString:keyStr].location,[[tempStr string] rangeOfString:keyStr].length);
        NSString *tem = [NSString string];
        for (int i = 0; i < keyStr.length; i ++){
            tem = [tem stringByAppendingString:@"*"];
        }
        [tempStr replaceCharactersInRange:colorRange withString:tem];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    return attributeStr;
}

// 调整行高加颜色
+ (NSMutableAttributedString *)changeLineHeightAndColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString*>*)keyArray color:(UIColor *)color lineHeight:(CGFloat)height{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = height;
    paragraphStyle.maximumLineHeight = height;
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:result];
    // 去重
    for (NSString *keyStr in keyArray){
        NSRange colorRange = NSMakeRange([[tempStr string] rangeOfString:keyStr].location,[[tempStr string] rangeOfString:keyStr].length);
        NSString *tem = [NSString string];
        for (int i = 0; i < keyStr.length; i ++){
            tem = [tem stringByAppendingString:@"*"];
        }
        [tempStr replaceCharactersInRange:colorRange withString:tem];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    return attributeStr;
}

// 调整行高
+ (NSMutableAttributedString *)changeLineHeightWithStr:(NSString *)result lineHeight:(CGFloat)height{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = height;
    paragraphStyle.maximumLineHeight = height;
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    return attributeStr;
}

// 调整首行缩进
+ (NSMutableAttributedString *)changeHeadSapceWithStr:(NSString *)result headSpacing:(CGFloat)headSpace{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setFirstLineHeadIndent:headSpace]; //首行缩进
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    return attributeStr;
}

// 调整首行缩进、行间距
+ (NSMutableAttributedString *)changeLineSpaceAndHeadSapceWithStr:(NSString *)result lineSpacing:(CGFloat)spacing headSpacing:(CGFloat)headSpace{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing]; //调整行间距
    [paragraphStyle setFirstLineHeadIndent:headSpace]; //首行缩进
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    return attributeStr;
}

//改变字体颜色
+ (NSMutableAttributedString *)changeTextColorWithStr:(NSString *)result changeText:(NSString *)text color:(UIColor *)color {
    if (!result) return [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];
    if (!text) return attributuStr;
    NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
    [attributuStr addAttributes:@{NSForegroundColorAttributeName:color} range:textRange];
    return attributuStr;
}

//更改多个字体颜色
+ (NSMutableAttributedString *)changeSomeTextColorWithStr:(NSString *)result changeTextArray:(NSArray <NSString *>*)array color:(UIColor *)color {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:result];
    // 去重
    for (NSString *keyStr in array){
        if (keyStr.length == 0) continue;
        NSRange colorRange = NSMakeRange([[tempStr string] rangeOfString:keyStr].location,[[tempStr string] rangeOfString:keyStr].length);
        NSString *tem = [NSString string];
        for (int i = 0; i < keyStr.length; i ++){
            tem = [tem stringByAppendingString:@"*"];
        }
        [tempStr replaceCharactersInRange:colorRange withString:tem];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    return attributeStr;
}

//找出要更改的字体数组
+ (NSArray *)checkChangeArrayWitStr:(NSString *)result andMarkStr:(NSString *)markStr {
    
    NSMutableArray *keyArray = [NSMutableArray array];
    NSString *temp = @"";
    BOOL fromStart = NO;
    int temIndex = 0;
    for (int i = 0; i < result.length-markStr.length; i++) {
        temp = [result substringWithRange:NSMakeRange(i, 6)];
        if ([temp isEqualToString:markStr]){
            if (fromStart){
                NSRange range = NSMakeRange(temIndex, i-temIndex);
                NSString *subStr = [result substringWithRange:range];
                [keyArray addObject:subStr];
            }else {
                temIndex = i+6;
            }
            fromStart = !fromStart;
        }
    }
    return keyArray;
}

//改变字体大小
+ (NSMutableAttributedString *)changeTextSizeWithStr:(NSString *)result changeText:(NSString *)text font:(UIFont *)font {
    
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
    [attributuStr addAttributes:@{NSFontAttributeName:font} range:textRange];
    return attributuStr;
}

//更改多个字体大小
+ (NSMutableAttributedString *)changeSomeTextSizeWithStr:(NSString *)result changeTextArray:(NSArray <NSString *>*)array font:(UIFont *)font {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:result];
    // 去重
    for (NSString *keyStr in array){
        NSRange colorRange = NSMakeRange([[tempStr string] rangeOfString:keyStr].location,[[tempStr string] rangeOfString:keyStr].length);
        NSString *tem = [NSString string];
        for (int i = 0; i < keyStr.length; i ++){
            tem = [tem stringByAppendingString:@"*"];
        }
        [tempStr replaceCharactersInRange:colorRange withString:tem];
        [attributeStr addAttribute:NSFontAttributeName value:font range:colorRange];
    }
    return attributeStr;
}

//改变字体大小和颜色
+ (NSMutableAttributedString *)changeTextFontColorWithStr:(NSString *)result changeText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
    [attributuStr addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:textRange];
    return attributuStr;
}

//封装的保留两位的逗号分隔方法
+ (NSString *)changeMoneyPositiveFormat:(NSString *)text{
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"%.2f",text.floatValue];
    };

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
}

// 手机号加星号
+ (NSString *)phoneNumberAddSymbols:(NSString *)number {
    if (number.length >= 4){
        return [NSString stringWithFormat:@"%@****%@",[number substringToIndex:3], [number substringWithRange:NSMakeRange(number.length - 4, 4)]];
    }else {
        return number;
    }
}

//数组或字典转为json字符串
+ (NSString *)arrayOrDictionaryToJsonString:(id)obj {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonString != nil && error == nil){
        return jsonString;
    }else{
        // 解析错误
        return nil;
    }
}
// 数组字典转json并去除转义字符
+ (NSString *)arrayOrDictionaryToJsonStringClearEscapeCharacter:(id)obj {
    NSString *str = [ToolsHelper arrayOrDictionaryToJsonString:obj];
    [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

// 将JSON串转化为数组
+ (NSArray *)jsonToArray:(NSString *)json{
    NSError *error = nil;
    if (json.length <= 0) return @[];
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return @[];
    }
}

// 将JSON串转化为字典
+ (NSDictionary *)jsonToDictionary:(NSString *)json{
    NSError *error = nil;
    if (!json) return @{};
    if (json.length <= 0) return @{};
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return @{};
    }
}

// 去除某些字，获取天气的时候不需要
+ (NSString *)removeSomeCityText:(NSString *)cityName {
    if (cityName.length <= 0) return @"";
    NSArray *array = @[@"市",@"自治州",@"地区",@"盟"];
    for (NSString *key in array) {
       cityName = [cityName stringByReplacingOccurrencesOfString:key withString:@""];
    }
    return cityName;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC{
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        controller = [(UITabBarController *)controller selectedViewController];
    }
  
    if([controller isKindOfClass:[UINavigationController class]]) {
        controller = [(UINavigationController *)controller visibleViewController];
    }
    if (!controller) {
        return [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return controller;
}

/** 圆圈背景获取不同背景色 */
+ (UIColor *)backgroundColorWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return [UIColor colorWithHex:0x65A0F8]; // 蓝色
            break;
        case 1:
            return [UIColor colorWithHex:0x6CCEA4]; // 绿色
            break;
        case 2:
            return [UIColor colorWithHex:0xE77370]; // 红色
            break;
        case 3:
            return [UIColor colorWithHex:0xF3CB6B]; // 黄色
            break;
        case 4:
            return [UIColor colorWithHex:0x6ED0D2]; // 墨绿
            break;
        default:
            return [UIColor colorWithHex:0x65A0F8]; // 蓝色
            break;
    }
}

/*
 *maxLengthKB 压缩到的大小
 *image 准备压缩的图片
 */
+(void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB image:(UIImage *)image Block :(void (^)(NSData *imageData))block{
    if (maxLengthKB <= 0 || [image isKindOfClass:[NSNull class]] || image == nil) block(nil);
    
    maxLengthKB = maxLengthKB*1024;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(image, compression);
        NSLog(@"初始: %lu KB",(unsigned long)data.length/1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"压缩完成：%lu KB",(unsigned long)data.length/1024);
                block(data);
            });
            return;
        }
        //质量压缩
        CGFloat scale = 1;
        CGFloat lastLength=0;
        for (int i = 0; i < 7; ++i) {
            compression = scale / 2;
            data = UIImageJPEGRepresentation(image, compression);
            NSLog(@"质量压缩中 %lu KB",(unsigned long)data.length/1024);
            if (i>0) {
                if (data.length>0.95*lastLength) break;//当前压缩后大小和上一次进行对比，如果大小变化不大就退出循环
                if (data.length < maxLengthKB) break;//当前压缩后大小和目标大小进行对比，小于则退出循环
            }
            scale = compression;
            lastLength = data.length;
            
        }
        NSLog(@"压缩图片质量后: %lu KB",(unsigned long)data.length/1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"压缩完成： %lu KB",(unsigned long)data.length/1024);
                block(data);
            });
            return;
        }
        
        //大小压缩
        UIImage *resultImage = [UIImage imageWithData:data];
        NSUInteger lastDataLength = 0;
        while (data.length > maxLengthKB && data.length != lastDataLength) {
            lastDataLength = data.length;
            CGFloat ratio = (CGFloat)maxLengthKB / data.length;
            NSLog(@"Ratio = %.1f", ratio);
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
            NSLog(@"绘图压缩中：%lu KB",(unsigned long)data.length/1024);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"压缩完成：%lu KB",(unsigned long)data.length/1024);
            block(data);
        });return;
    });
}

/**
 压缩图片
 */
+ (UIImage *)compressImage:(UIImage *)image toKB:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    maxLength = maxLength*1024;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    NSLog(@"原始图片大小:%lu",(unsigned long)data.length);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return resultImage;
}

//合并图片 第二张图在第一张中心
+ (UIImage *)combine:(UIImage *)oneImage otherImage:(UIImage *)otherImage {
    //计算画布大小
    CGFloat width = oneImage.size.width;
    CGFloat height = oneImage.size.height;
    CGSize resultSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(resultSize);
    //放第一个图片
    CGRect oneRect = CGRectMake(0, 0, resultSize.width, resultSize.height);
    [oneImage drawInRect:oneRect];
    //放第二个图片
    CGRect otherRect = CGRectMake((resultSize.width -  otherImage.size.width)/2.0, (resultSize.height -  otherImage.size.height)/2.0, otherImage.size.width, otherImage.size.height);
    [otherImage drawInRect:otherRect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

// 更改图片大小
+ (UIImage *)changeImage:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;

    UIGraphicsBeginImageContext(targetSize);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;

    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage ;
}

// 获取图片第一帧
+ (UIImage*)getVideoPreViewImage:(NSURL *)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}

/**
 * 截取图片
 * @param theView 要截图的View
 * @param scale 缩放比例 设置为0会自动获取系统缩放因子[UIScreen mainScreen].scale
 * @param maxLength 压缩大小 如果为0，默认不压缩
 */
+ (UIImage *)screenImageFromView:(UIView *)theView scale:(CGFloat )scale compressToKB:(NSUInteger)maxLength{
    //开启上下文 self.baseZoomScale 图片缩放比例，可控制截屏图片大小 alpha 控制透明度
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, scale);//self.baseZoomScale
    // 将view内容渲染到图形上下文
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 取得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 具体大小的图片
//    CGImageRef subimageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, ScreenWidth*ScreenScale, ScreenHeight*ScreenScale));
//    UIImage *subImage = [UIImage imageWithCGImage:subimageRef];
    // 关闭上下文
    UIGraphicsEndImageContext();
    UIImage *resultImage;
    if (maxLength == 0){
        resultImage = image;
    }else {
        resultImage = [ToolsHelper compressImage:image toKB:maxLength];
    }
    return resultImage;
}

/**
* 截取图片 特殊处理 openGL 不规则形状截取方案
* @param theView 要截图的View
* @param scale 缩放比例 设置为0会自动获取系统缩放因子[UIScreen mainScreen].scale
* @param maxLength 压缩大小 如果为0，默认不压缩
* @param isAfter yes-会在数据加载后截取 no-直接截取
*/
+ (UIImage *)screenUpdateImageFromView:(UIView *)theView scale:(CGFloat )scale compressToKB:(NSUInteger)maxLength afterScreenUpdates:(BOOL)isAfter{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, scale);
    [theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:isAfter];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *resultImage;
    if (maxLength == 0){
        resultImage = image;
    }else {
        resultImage = [ToolsHelper compressImage:image toKB:maxLength];
    }
    return resultImage;
}

/**
 * 截取tableView和scrollView 长图，tableview初始化要用基础的frame初始化，自动布局有问题会截取不全
 */
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    CGRect  savedFrame = scrollView.frame;
    scrollView.showsVerticalScrollIndicator = NO;
    CGSize size = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height);
    //第一个参数表示区域大小。第二个参数表示透明开关，如果图形完全不用透明，设置为YES以优化位图的存储.第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    //iOS7 提供的截屏新方法，可以不在主线程做
    [scrollView drawViewHierarchyInRect:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    scrollView.frame = savedFrame;
    scrollView.showsVerticalScrollIndicator = YES;
    if(image != nil){
        return image;
    }
    return nil;
}

@end

