
#import "XLNetworkingManager.h"

@implementation XLNetworkingManager

+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(XLResponseSuccess)success
    failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)GET:(NSString *)url
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(XLResponseSuccess)success
    failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
    
}

+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(XLResponseSuccess)success
     failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)POST:(NSString *)url
     baseURL:(NSString *)baseUrl
      params:(NSDictionary *)params
     success:(XLResponseSuccess)success
     failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *) mimeType
             progress:(XLProgress)progress
              success:(XLResponseSuccess)success
              failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (void)uploadWithURL:(NSString *)url
              baseURL:(NSString *)baseurl
               params:(NSDictionary *)params
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *) mimeType
             progress:(XLProgress)progress
              success:(XLResponseSuccess)success
              failure:(XLResponseFailure)failure {
    
    AFHTTPSessionManager *manager = [XLNetworkingManager managerWithBaseURL:baseurl sessionConfiguration:YES];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSONDictionary = [XLNetworkingManager responseConfiguration:responseObject];
        NSString *JSONString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        success(task, JSONDictionary, JSONString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *HTTPURLResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = HTTPURLResponse.statusCode;
        NSString *requestFailedReason = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failure(task, error, statusCode, requestFailedReason);
    }];
}

+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                  savePathURL:(NSURL *)fileURL
                                     progress:(XLProgress )progress
                                      success:(void (^)(NSURLResponse *, NSURL *))success
                                      failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        } else {
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL
                        sessionConfiguration:(BOOL)isconfiguration {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+ (NSDictionary *)responseConfiguration:(id)responseObject {
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}

@end
