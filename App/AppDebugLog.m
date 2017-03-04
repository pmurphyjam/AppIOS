//
//  AppDebugLog.m
//  AppIOS
//
//  Created by Pat Murphy on 5/16/14.
//  Copyright (c) 2014 Fitamatic All rights reserved.
//
//  Info : writes out a Debug log for catching events.
//  Overwrites it once it get's to 10M in size so it doesn't get too large.
//

#import "AppDebugLog.h"
#import "AppDateFormatter.h"
#include <pthread.h>
#import <CoreText/CoreText.h>

@interface AppDebugLog ()
{
    dispatch_queue_t _queue;
}

@end

@implementation AppDebugLog

static 	unsigned long long fileLength;

#define DEBUG_LOG_FILE @"AppDebug.log"
#define DEBUG_PDF_FILE @"Debug.pdf"
#define DEBUG_OLD_LOG_FILE @"AppDebug_old.log"
#define DEBUG_LOG_FILE_LENGTH 10000000

+ (instancetype)appDebug
{
    static dispatch_once_t predicate;
    static AppDebugLog *appDebugLog = nil;
    
    dispatch_once(&predicate, ^{
        appDebugLog = [[self alloc] init];
    });
    return appDebugLog;
}

- (id)init
{
    if ((self = [super init]))
    {
        _queue = dispatch_queue_create("com.abexample.AppDebugLog", NULL);
    }
    return self;
}

-(void)writeDebugData:(NSString*)debugStr
{
    NSString *threadNameStr = [[NSThread currentThread] name];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    
    if([[NSThread currentThread] isMainThread])
        threadNameStr = [NSString stringWithFormat:@"Main:%x",machTID];
    else
    {
        if([threadNameStr length] == 0)
            threadNameStr = [NSString stringWithFormat:@"Back:%x",machTID];
        else
            threadNameStr = [threadNameStr stringByAppendingFormat:@":%x",machTID];
    }
    //Write this on a background thread
    dispatch_async(_queue, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *debugFileName = [documentsDirectory stringByAppendingPathComponent:DEBUG_LOG_FILE];
        NSString *debugFileNameOld = [documentsDirectory stringByAppendingPathComponent:DEBUG_OLD_LOG_FILE];
        NSFileHandle *aFileHandle = [NSFileHandle fileHandleForWritingAtPath:debugFileName];
        AppDateFormatter *dateFormatter = [[AppDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        NSString *debugStrLoc = [NSString stringWithFormat:@"%@ [%@] %@ \n",[dateFormatter stringFromDate:[NSDate date]],threadNameStr,debugStr];
        
        if(aFileHandle == nil || fileLength > DEBUG_LOG_FILE_LENGTH) {
            NSError *error = nil;
            if(aFileHandle != nil) {
                NSFileManager *fileManager = [[NSFileManager alloc] init];
                [fileManager moveItemAtPath:debugFileName toPath:debugFileNameOld error:&error];
            }
            [debugStrLoc writeToFile:debugFileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
        }
        
        if(aFileHandle != nil)
        {
            @synchronized(aFileHandle)
            {
                [aFileHandle truncateFileAtOffset:[aFileHandle seekToEndOfFile]];
                [aFileHandle writeData:[debugStrLoc dataUsingEncoding:NSUTF8StringEncoding]];
                fileLength = [aFileHandle offsetInFile];
                [aFileHandle synchronizeFile];
                [aFileHandle closeFile];
            }
        }
    });
}

+(void)createLog
{
    NSLog(@"AppDebugLog : createLog : AppDebugLog");
    fileLength = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *debugFileName = [documentsDirectory stringByAppendingPathComponent:DEBUG_LOG_FILE];
    NSFileHandle *aFileHandle = [NSFileHandle fileHandleForWritingAtPath:debugFileName];
    // First delete the old one, and then create the new one
    NSError *error = nil;
    if(aFileHandle != nil)
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        [fileManager removeItemAtPath:debugFileName error:&error];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *debugStrLoc = [NSString stringWithFormat:@"************************  Debug Log Created : %@  ************************ \n",[dateFormatter stringFromDate:[NSDate date]]];
    [debugStrLoc writeToFile:debugFileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

-(NSData*)getPDFDebugLog
{
    [self createPDF];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *debugFileName = [documentsDirectory stringByAppendingPathComponent:DEBUG_PDF_FILE];
    NSFileHandle *fileManager = [NSFileHandle fileHandleForReadingAtPath:debugFileName];
    NSData *buffer = [fileManager readDataToEndOfFile];
    return buffer;
}

- (void)createPDF
{
    //Get Document Directory path
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //Define path for PDF file
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:DEBUG_PDF_FILE];
    //Get current debug log
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *debugFileName = [documentsDirectory stringByAppendingPathComponent:DEBUG_LOG_FILE];
    NSFileHandle *fileManager = [NSFileHandle fileHandleForReadingAtPath:debugFileName];
    NSData *debugLogData = [fileManager readDataToEndOfFile];
    NSString *debugLogStr = [[NSString alloc] initWithData:debugLogData encoding:NSUTF8StringEncoding];
    
    // Prepare the text using a Core Text Framesetter.
    CFMutableAttributedStringRef currentText = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (currentText, CFRangeMake(0, 0), (__bridge CFStringRef) debugLogStr);
    CTFontRef font = CTFontCreateWithName(CFSTR("Times New Roman"), 10, NULL);
    CFAttributedStringSetAttribute(currentText, CFRangeMake(0, CFAttributedStringGetLength(currentText)), kCTFontAttributeName, font);
    
    if (currentText) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
        if (framesetter)
        {
            // Create the PDF context using the default page size of 612 x 792.
            UIGraphicsBeginPDFContextToFile(documentPath, CGRectZero, nil);
            CFRange currentRange = CFRangeMake(0, 0);
            NSInteger currentPage = 0;
            BOOL done = NO;
            
            do
            {
                // Mark the beginning of a new page.
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                // Draw a page number at the bottom of each page.
                currentPage++;
                [self drawPageNbr:currentPage];
                // Render the current page and update the current range to
                // point to the beginning of the next page.
                currentRange = *[self updatePDFPage:currentPage setTextRange:&currentRange setFramesetter:&framesetter];
                // If we're at the end of the text, exit the loop.
                if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                    done = YES;
            } while (!done);
            
            // Close the PDF context and write the contents out.
            UIGraphicsEndPDFContext();
            // Release the framewetter.
            CFRelease(framesetter);
        }
        else
        {
            NSLog(@"AppDebugLog : createPDF : Could not create the framesetter");
        }
        // Release the attributed string.
        CFRelease(currentText);
    }
    else
    {
        NSLog(@"AppDebugLog : createPDF : currentText could not be created");
    }
}

-(void)drawPageNbr:(NSInteger)pageNumber
{
    NSString *setPageNum = [NSString stringWithFormat:@"-%d-",(int)pageNumber];
    UIFont *pageNbrFont = [UIFont fontWithName:@"Times New Roman" size:10];
    
    CGSize maxSize = CGSizeMake(612, 72);
    CGSize pageStringSize = [setPageNum sizeWithFont:pageNbrFont
                                   constrainedToSize:maxSize
                                       lineBreakMode:NSLineBreakByClipping];
    
    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
                                   720.0 + ((72.0 - pageStringSize.height) / 2.0),
                                   pageStringSize.width,
                                   pageStringSize.height);
    [setPageNum drawInRect:stringRect withFont:pageNbrFont];
}

-(CFRange*)updatePDFPage:(NSInteger)pageNumber setTextRange:(CFRange*)pageRange setFramesetter:(CTFramesetterRef*)framesetter
{
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect frameRect = CGRectMake(72, 72, 468, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(*framesetter, *pageRange, framePath, NULL);
    CGPathRelease(framePath);
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    // Update the current range based on what was drawn.
    *pageRange = CTFrameGetVisibleStringRange(frameRef);
    pageRange->location += pageRange->length;
    pageRange->length = 0;
    CFRelease(frameRef);
    return pageRange;
}

@end
