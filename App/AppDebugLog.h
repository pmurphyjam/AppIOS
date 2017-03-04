//
//  AppDebugLog.h
//  AppIOS
//
//  Created by Pat Murphy on 5/16/14.
//  Copyright (c) 2014 Fitamatic All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDebugLog : NSObject

+(instancetype)appDebug;
-(void)writeDebugData:(NSString*)debugStr;
+(void)createLog;
-(NSData*)getPDFDebugLog;

@end
