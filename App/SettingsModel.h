//
//  SettingsModel.h
//  AppIOS
//
//  Created by Pat Murphy on 5/16/14.
//  Copyright (c) 2014 Fitamatic All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsModel : NSObject

+(void)logout;
+(void)setAccountID:(NSString*)userID;
+(NSString*)getAccountID;
+(void)setUserName:(NSString*)userName;
+(NSString*)getUserName;
+(void)setEmailAddress:(NSString*) password;
+(NSString*)getEmailAddress;
+(void)setFirstName:(NSString*)loginName;
+(NSString*)getFirstName;
+(void)setLastName:(NSString*)loginName;
+(NSString*)getLastName;
+(void)setUserId:(NSNumber*)userId;
+(NSNumber*)getUserId;
+(NSString*)getUserStrId;
+(void)setGotNewOne:(BOOL)gotNewOne;
+(BOOL)getGotNewOne;
+(void)setDBPW0:(NSString*)someStr;
+(NSString*)getDBPW0;
+(void)setDBPW1:(NSString*)someStr;
+(NSString*)getDBPW1;
+(void)setDBDS0:(NSString*)someStr;
+(NSString*)getDBDS0;
+(void)setDBDS1:(NSString*)someStr;
+(NSString*)getDBDS1;
+(void)setDBIsEncrypted:(BOOL)dbEncrpted;
+(BOOL)getDBIsEncrypted;

+(void)setDBCanEncrypt:(BOOL)dbEncrpted;
+(BOOL)getDBCanEncrypt;


+(NSString*)getBuildDate;
+(NSString*)getGitCommit;
+(void)setLoginState:(BOOL)loginState;
+(BOOL)getLoginState;
+(void)setSessionID:(NSString*)sessionID;
+(NSString*)getSessionID;
+(void)setUserTopic;
+(void)setCountry:(NSString*)country;
+(NSString*)getCountry;
+(void)setTotalUserContacts:(NSNumber*)totalUserContacts;
+(NSNumber*)getTotalUserContacts;
+(void)setProcessingContacts:(BOOL)processingContacts;
+(BOOL)getProcessingContacts;
+(void)setTotalCalendarEvents:(NSNumber*)totalCalendarEvents;
+(NSNumber*)getTotalCalendarEvents;
+(void)setCalendarAuthorization:(BOOL)calendarAuthorization;
+(BOOL)getCalendarAuthorization;
+(void)setProcessingCalendarEvents:(BOOL)processingCalendar;
+(BOOL)getProcessingCalendarEvents;
+(NSString*)getUserTopic;
+(NSString*)getAppVersion;
+(NSString*)getBuildValue;
+(NSString*)getBuildVersion;
//Used for Performance measuring
+(void)setStartDateTimeStamp:(NSString*)startDateTime forIndex:(int)index;
+(void)setFinishDateTimeStamp:(NSString*)finishDateTime forIndex:(int)index;
+(NSTimeInterval)getStartToFinishTimeForIndex:(int)index;

@end
