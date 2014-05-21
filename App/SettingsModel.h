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
+(void)setGotNewOne:(BOOL)gotNewOne;
+(BOOL)getGotNewOne;
+(void)setPW0:(NSString*)someStr;
+(NSString*)getPW0;
+(void)setPW1:(NSString*)someStr;
+(NSString*)getPW1;
+(void)setDS0:(NSString*)someStr;
+(NSString*)getDS0;
+(void)setDS1:(NSString*)someStr;
+(NSString*)getDS1;
+(void)setIsDBEncrypted:(BOOL)dbEncrpted;
+(BOOL)getIsDBEncrypted;
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
+(NSString*)getUserTopic;
+(NSString*)getAppVersion;
+(NSString*)getBuildValue;
+(NSString*)getBuildVersion;
//Used for Performance measuring
+(void)setStartDateTimeStamp:(NSString*)startDateTime forIndex:(int)index;
+(void)setFinishDateTimeStamp:(NSString*)finishDateTime forIndex:(int)index;
+(NSTimeInterval)getStartToFinishTimeForIndex:(int)index;

@end
