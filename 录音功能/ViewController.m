//
//  ViewController.m
//  录音功能
//
//  Created by yanbo on 17/8/17.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "YBAudioTool.h"
#import "YBAudioFileTool.h"
#import "LameTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)start:(id)sender {
//     ios 所支持的音频格式，如果需要跨平台进行音频数据交换，只有 AAC 和 Linear PCM 可以选择
    [[YBAudioTool shareInstance] beginRecordWithRecordPath:@"/Users/julyonline/Desktop/demo/11.caf"];
    
    
}
- (IBAction)end:(id)sender {
    
    [[YBAudioTool shareInstance] endRecord];

}
- (IBAction)delete:(id)sender {
    
    [[YBAudioTool shareInstance] deleteRecord];

}
- (IBAction)play:(id)sender {
    
    [YBAudioFileTool cutAudio:@"/Users/julyonline/Desktop/demo/33.mp3" fromTime:100 toTime:180 outputPath:@"/Users/julyonline/Desktop/demo/33.m4a"];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // 编辑录音
//    [YBAudioFileTool addAudio:@"/Users/julyonline/Desktop/demo/22.mp3" toAudio:@"/Users/julyonline/Desktop/demo/33.mp3" outputPath:@"/Users/julyonline/Desktop/demo/44.m4a"];
    
    
    [LameTool audioToMp3:@"/Users/julyonline/Desktop/demo/11.caf" isDeleteSourceFile:NO];
    
}
































@end
