
#import "XLWebView.h"
#import "RegExCategories.h"
#import "UIColor+XLsn0w.h"

@interface XLWebView () <UIAlertViewDelegate>

@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation XLWebView

static XLWebView *instance = nil;
+ (XLWebView *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XLWebView alloc] init];
    });
    return instance;
}

- (void)load {
    self.backgroundColor = [UIColor xlsn0w_hexString:@"#EFEFF4"];
    if(!_isLoad){
        [self loadRequest:[self addHeaderIntoRequest:[NSURL URLWithString:_url]]];
        _isLoad = !_isLoad;
    }
}

- (void)reload {
    [self loadRequest:[self addHeaderIntoRequest:[NSURL URLWithString:self.url]]];
}

- (NSDictionary*)urlToDictionaryWithParameter:(NSString *)url {
    if(![url containsString:@"?"]){
        return @{};
    }
    NSString* paramStr = [url substringFromIndex:NSMaxRange([url rangeOfString:@"?"])];
    NSMutableDictionary* dict= [NSMutableDictionary new];
    for(NSString* p in [paramStr componentsSeparatedByString:@"&"]){
        NSArray* array = [p componentsSeparatedByString:@"="];
        [dict addEntriesFromDictionary:@{array[0]:array[1]}];
    }
    return dict;
}

- (BOOL)handleRequest:(NSURLRequest *)request viewController:(UIViewController *)viewController {
    return [self handleRequest:request webView:nil viewController:viewController];
}

- (BOOL)handleRequest:(NSURLRequest *)request webView:(UIWebView *)webview viewController:(UIViewController *)viewController{
    NSString *UrlPath = request.URL.path;
    NSString *url = [[request.URL absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"path=%@,url=%@",UrlPath,url);
    
    
    if([UrlPath hasPrefix:@"/user/service"]){
        return YES;
    }
    if([UrlPath hasPrefix:@"tel:"]){
        NSString* tel = [UrlPath firstMatch:RX(@"\\d+")];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        return NO;
    }
    
    if([@"about:blank" isEqualToString:url]){
        return NO;
    }
    
    //回退并提示
    if([UrlPath hasPrefix:@"/back"]){
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] show];
        [viewController.navigationController popViewControllerAnimated:YES];
        
    }else if([UrlPath hasPrefix:@"/item/detail"]){

        
//        if(itemSku){
//            controller.hidesBottomBarWhenPushed = YES;
//            [UIViewController go2itemDetailViewController:controller andParams:@{@"sku":itemSku}];
//            if([NSStringFromClass(controller.class) isEqualToString:@"FXPurchaseViewController"]){
//                controller.hidesBottomBarWhenPushed = NO;
//            }
//            if([NSStringFromClass(controller.class) isEqualToString:@"FXWarehouseViewController"]){
//                controller.hidesBottomBarWhenPushed = NO;
//            }
//            if([NSStringFromClass(controller.class) isEqualToString:@"FXDeliveryViewController"]){
//                controller.hidesBottomBarWhenPushed = NO;
//            }
//            if([NSStringFromClass(controller.class) isEqualToString:@"FXIndexViewController"]){
//                controller.hidesBottomBarWhenPushed = NO;
//            }
//        }
        return NO;
    }else if([UrlPath hasPrefix:@"/user/success"]){
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] show];
     
        
        return NO;
    }
    
    return YES;
}





- (NSMutableURLRequest *)addHeaderIntoRequest:(NSURL *)url{
//    NSString* userId = [NSString stringWithFormat:@"%i",[FXGlobalKit sharedKit].user.id.intValue];
//    NSString* userSession = [FXGlobalKit sharedKit].user.session;
//    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"iphone" forHTTPHeaderField:@"platform"];
    [request addValue:version forHTTPHeaderField:@"version"];
    
//    if(userId && userSession){
//        [request addValue:userId forHTTPHeaderField:@"user_id"];
//        [request addValue:userSession forHTTPHeaderField:@"user_session"];
//    }else{
//        [request addValue:@"" forHTTPHeaderField:@"user_id"];
//        [request addValue:@"" forHTTPHeaderField:@"user_session"];
//    }
    return request;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){

    }
}

@end
