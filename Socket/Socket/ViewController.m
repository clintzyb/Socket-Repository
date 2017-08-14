//
//  ViewController.m
//  Socket
//
//  Created by zhu yuanbin on 07/08/2017.
//  Copyright © 2017 zhuyuanbin. All rights reserved.
//

#import "ViewController.h"
#import "Socket-Bridging-Header.h"
#import "Masonry.h"
@interface ViewController ()<NSStreamDelegate>
@property(nonatomic,strong) NSInputStream * inputStream;
@property(nonatomic,strong) NSOutputStream * outputStream;
@property(nonatomic,strong) LineChartView * lineChar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self connectServier];
    
}

-(void)connectServier{
//    NSString * host = @"10.0.0.4";
//    int port = 1122;
//    
//    CFReadStreamRef readStream;
//    CFWriteStreamRef writeStream;
//    
//    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
//    
//    self.inputStream = (__bridge NSInputStream*)(readStream);
//    self.outputStream = (__bridge NSOutputStream*)(writeStream);
//    
//    self.inputStream.delegate = self;
//    self.outputStream.delegate = self;
//    
//    
//    [self.inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    [self.outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    
//    [self.inputStream open];
//    [self.outputStream open];
//    
}

-(void)readData{
    
    uint8_t buf[1024];
    NSInteger len = [self.inputStream read:buf maxLength:sizeof(buf)];
    
    NSData * data = [NSData dataWithBytes:buf length:len];
    
    NSString * readDataSring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data:%@",readDataSring);

}


- (IBAction)senddata:(id)sender {


    NSString * sendString = @"要发送的数据";
    NSData * sendData = [sendString dataUsingEncoding:NSUTF8StringEncoding];
    [self.outputStream write:sendData.bytes maxLength:sendData.length];
    
}

#pragma mark NSStreamDelegate

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有可读字节");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"有可发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"链接结束");
//            [self.inputStream close];
//            [self.outputStream close];
//            [self.inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//            [self.outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            break;
            
        default:
            break;
    }

}
@end
