//
//  YBAudioTool.m
//  录音功能
//
//  Created by yanbo on 17/8/17.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBAudioTool.h"
#import "YBAudioTool.h"

@interface YBAudioTool ()

@property(nonatomic, copy) Success block;

@property(nonatomic, strong) AVAudioRecorder *audioRecorder;


@end


@implementation YBAudioTool

singtonImplement(YBAudioTool)

-(AVAudioRecorder *)audioRecorder{
    
    if (!_audioRecorder) {
        // 0.设置录音会话
//        设置音频会话类型为AVAudioSessionCategoryPlayAndRecord，因为程序中牵扯到录音和播放操作。
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        //开启会话
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        // 1.确定录音存放的位置
        NSURL *url = [NSURL URLWithString:self.recordPath];
        
        // 2. 设置录音参数
        NSMutableDictionary *recordSettings = [NSMutableDictionary dictionary];
        
        //     ios 所支持的音频格式，如果需要跨平台进行音频数据交换，只有 AAC 和 Linear PCM 可以选择
        //  设置编码格式
//        kAudioFormatMPEG4AAC  .m4a
        
//        kAudioFormatLinearPCM  .caf
        
//        AAC 对音频进行压缩，音频数据较小
        
//        Linear PCM未对音频进行压缩，实时性更好，但音频数据较大
        [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
//        
//            [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey];
        // 采样率
         //采样率  8000/11025/22050/44100/96000（影响音频的质量）
        [recordSettings setValue:@(11025.0) forKey:AVSampleRateKey];
        
        // 通道数
        [recordSettings setValue:@(2) forKey:AVNumberOfChannelsKey];
        
        //音频质量，
        [recordSettings setValue:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
        
        
        
        // 3. 创建录音对象
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSettings error:nil];
        
//        是否启用录音测量，如果启用录音测量可以获得录音分贝等数据信息
        _audioRecorder.meteringEnabled = YES;
        
    }
    
    return _audioRecorder;
}


-(void)updateMeters{
    
//    更新测量数据，注意只有meteringEnabled为YES此方法才可用
    [self.audioRecorder updateMeters];
}


//开始录音
-(void)beginRecordWithRecordPath:(NSString *)recordPath{
    
    _recordPath = recordPath;
    
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
}

// 结束录音
-(void)endRecord{
    
    [self.audioRecorder stop];
}

// 暂停录音
-(void)pauseRecord{
    [self.audioRecorder pause];
    
    
}

//删除录音
-(void)deleteRecord{
//     	删除录音，注意要删除录音此时录音机必须处于停止状态
    [self.audioRecorder stop];
    [self.audioRecorder deleteRecording];

}


// 重新录音
-(void)reRecord{
    
    
    self.audioRecorder = nil;
    
    [self beginRecordWithRecordPath:self.recordPath];
    
    
}




- (float)peakPowerForChannel0 {
    
//    指定通道的测量峰值，注意只有调用完updateMeters才有值
    [self.audioRecorder updateMeters];
    return [self.audioRecorder peakPowerForChannel:0];
}














@end
