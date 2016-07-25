
#import <UIKit/UIKit.h>

@protocol XLWebViewDelegate <NSObject>

- (void)loadXLWebViewCallback:(NSDictionary *)dictionary;

@end

@interface XLWebView : UIWebView

@property (nonatomic, copy) NSString *url;

+ (XLWebView *)sharedInstance;

- (void)load;

- (void)reload;

- (NSMutableURLRequest *)addHeaderIntoRequest:(NSURL *)url;

- (NSDictionary *)urlToDictionaryWithParameter:(NSString *)url;

- (BOOL)handleRequest:(NSURLRequest *)request viewController:(UIViewController *)viewController;

- (BOOL)handleRequest:(NSURLRequest *)request webView:(UIWebView *)webview viewController:(UIViewController *)viewController;

@end
