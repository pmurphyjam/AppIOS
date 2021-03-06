//
//  AppManager.h
//  AppIOS
//
//  Created by Pat Murphy on 5/16/14.
//  Copyright (c) 2014 Fitamatic All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccess.h"
#import "UTCDate.h"
#import "SettingsModel.h"

@interface AppManager : NSObject

+(void)InitializeAppManager;
+(BOOL)OpenDBConnection;
+(void)CloseDBConnection;
+(void)KillDB;
+(DataAccess*)DataAccess;
+(void)Finalize;
+(BOOL)IPad;
+(int)AppDefinitionID;
+(NSString*)UTCDateTime;
+(NSString*)CurrentDateTime;
+(NSString*)getUTCDateTimeForDate:(NSDate*)date;
+(NSDate*)getUTCDateTimeFromDateString:(NSString*)dateStr;
+(NSDate*)getDateFromDateString:(NSString*)dateStr;
+(NSString*)getDateStringFromDate:(NSDate*)date;
+(UTCDate*)UTCDate;
+(NSString*)PathForFileWithName:(NSString*)fileName;
+(NSDate*)dateForUTCDateString:(NSString*)date;
+(NSTimeInterval)UTCOffsetForDate:(NSString*)dateString;
+(void)currentMemoryConsumption:(NSString*)executionPoint;
+(void)saveExceptionData:(NSDictionary*)crashDic;
+(NSString *)getSectionHeaderfromDate:(NSDate*)date;
+(NSString *)getBirthDatefromDate:(NSDate*)date;
+(NSString *) getMediumDateWithDayOfWeekfromDate:(NSDate*)date;
+(NSString *) getMediumDatefromDate:(NSDate*)date;
+(NSDate *) getMediumDatefromString:(NSString*)dateStr;
+(NSString*)getMidNightForDate:(NSDate*)date;
+(NSString *)getSomeDSfromDate:(NSDate*)date;
+(NSString *)humanShortString:(NSDate*)date;
+(BOOL)DoesFileExistWithName:(NSString*)fileName;
+(BOOL)DeleteFileWithName:(NSString*)fileName;
+(BOOL)DoesLibraryFileExistWithName:(NSString*)fileName;
+(BOOL)DeleteLibraryFileWithName:(NSString*)fileName;
+(NSString*)ReturnPathForLibraryFileWithName:(NSString*)fileName;
+(NSMutableData*)AES256Encrypt:(NSString*)plainText;
+(NSString*)AES256Decrypt:(NSMutableData*)encryptData;
+(NSMutableData*)AES256EncryptDic:(NSDictionary*)plainDic;
+(NSDictionary*)AES256DecryptDic:(NSMutableData*)encryptData;
+(NSMutableArray*)getCrashData;
+(BOOL)crashDataExists;
+(BOOL)updateCrashData:(NSString*)crashID;
+(void)LogoutFromDB;

@end
