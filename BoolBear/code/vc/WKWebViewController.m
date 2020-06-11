//
//  WKWebViewController.m
//  TestWKWebView
//
//  Created by lk on 2019/5/13.
//  Copyright © 2019 lk. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *testLab;
@property (nonatomic, strong) UIButton *ocBtn;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WKWebView";
    [self addUI];
}

- (void)addUI
{
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    //通过JS与webView内容交互
    config.userContentController = [WKUserContentController new];
    [config.userContentController addScriptMessageHandler:self name:@"Back"];
    [config.userContentController addScriptMessageHandler:self name:@"Color"];
    [config.userContentController addScriptMessageHandler:self name:@"Param"];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    
    
    
//    [config.userContentController removeScriptMessageHandlerForName:@"Back"];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navigationView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 300) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WKWebViewText.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载本地html文件
    //[_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    //加载远程html文件
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.16.3.14:8080/WKWebViewText.html"]]];
    [self.view addSubview:self.webView];
    
    
    //label
    self.testLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.webView.frame), SCREEN_WIDTH, 60)];
    self.testLab.numberOfLines = 0;
    self.testLab.textAlignment = NSTextAlignmentCenter;
    self.testLab.text = @"我是原生的label";
    self.testLab.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.testLab];
    
    //ocBtn
    self.ocBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.ocBtn.frame = CGRectMake(0, CGRectGetMaxY(self.testLab.frame), SCREEN_WIDTH, 300-60);
    self.ocBtn.backgroundColor = [UIColor redColor];
    [self.ocBtn setTitle:@"我是ocBtn" forState:(UIControlStateNormal)];
    [self.ocBtn addTarget:self action:@selector(ocBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.ocBtn];
}

- (void)ocBtnAction:(UIButton *)sender
{
    NSString * paramString = @"我是 OC 调用 JS";
    //transferPrama()是JS的语言
    NSString * jsStr = [NSString stringWithFormat:@"transferPrama('%@')",paramString];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result=%@  error=%@",result, error);
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"Back"]) {
        NSLog(@"点击了 Back 按钮");
        self.testLab.text = [NSString stringWithFormat:@"%@",message.body];
    } else if ([message.name isEqualToString:@"Color"]) {
        NSLog(@"点击了 Color 按钮");
        CGFloat r = arc4random() % 255;
        CGFloat g = arc4random() % 255;
        CGFloat b = arc4random() % 255;
        CGFloat a = arc4random() % 10;
        self.testLab.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/10];
    } else if ([message.name isEqualToString:@"Param"]) {
        if (![message.body isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //获取网页传回来的数据
        NSString * firstStr = [message.body objectForKey:@"first"];
        NSString * secondStr = [message.body objectForKey:@"second"];
        self.testLab.text = [NSString stringWithFormat:@"%@%@",firstStr,secondStr];
    }
}

#pragma mark - WKUIDelegate
// 在JS端调用alert函数alert(content)时，会触发此代理方法，通过message可以拿到JS端所传的数据，在iOS端得到结果后，需要回调JS，通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// JS端调用confirm函数时，会触发此方法，通过message可以拿到JS端所传的数据，在iOS端显示原生alert得到YES/NO后，通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

//JS端调用prompt函数时，会触发此方法，要求输入一段文本，在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
