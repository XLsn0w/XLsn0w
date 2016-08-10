
#import "XLog.h"

#import "NSDate+BFKit.h"
#import "NSString+BFKit.h"

static NSString *logString = @"";
static NSString *logDetailedString = @"";

@implementation XLog

void ExtendNSLog(const char * _Nonnull file, int lineNumber, const char * _Nonnull function, NSString *format, ...) {
    va_list ap;
    
    va_start(ap, format);
    
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end(ap);
    
    NSString *functionName = [NSString stringWithFormat:@"%s", function];
    if ([functionName hasString:@"_block_invoke"]) {
        functionName = [functionName stringByReplacingWithRegex:@"__[0-9]*" withString:@""];
        functionName = [functionName stringByReplacingOccurrencesOfString:@"_block_invoke" withString:@""];
    }
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent].stringByDeletingPathExtension;
    NSString *log = [NSString stringWithFormat:@"%s:%d %s: %s", [fileName UTF8String], lineNumber, [functionName UTF8String], [body UTF8String]];
    fprintf(stderr, "%s %s:%d %s: %s", [[NSDate dateInformationDescriptionWithInformation:[[NSDate date] dateInformation] dateSeparator:@"-" usFormat:YES nanosecond:YES] UTF8String], [fileName UTF8String], lineNumber, [functionName UTF8String], [body UTF8String]);
    
    logString = [logString stringByAppendingString:[NSString stringWithFormat:@"%@", body]];
    
    logDetailedString = [logDetailedString stringByAppendingString:[NSString stringWithFormat:@"%@", log]];
}

+ (NSString * _Nonnull)logString {
    return logString;
}

+ (NSString * _Nonnull)detailedLogString {
    return logDetailedString;
}

+ (NSString * _Nonnull)logDetailedString {
    return logDetailedString;
}

+ (void)clearLog {
    logString = @"";
    logDetailedString = @"";
}

@end