//
//  AppDelegate.m
//  Socket
//
//  Created by zhu yuanbin on 07/08/2017.
//  Copyright © 2017 zhuyuanbin. All rights reserved.
//


// 推送到fdfasf
#import "AppDelegate.h"
#import "SRWebSocket.h"
@interface AppDelegate ()<SRWebSocketDelegate>
@property(nonatomic,strong) SRWebSocket * webSocket;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self createSRWebSocket];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)createSRWebSocket{
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://10.0.0.4:8888/medicine/socketTest"]]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}


#pragma mark -SRWebSocketDelegate

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"连接成功");
}


-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"连接失败");

}


-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//    NSData * data = [NSData dataWithBytes:message length:]
//   const char * ffff = [((NSString*)message) cStringUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"收到数据---%@",message);

}

-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{

    NSLog(@"链接断开");
}





@end
