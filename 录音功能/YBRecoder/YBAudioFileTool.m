//
//  YBAudioFileTool.m
//  录音功能
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBAudioFileTool.h"

#import <AVFoundation/AVFoundation.h>

@implementation YBAudioFileTool

+(void)addAudio:(NSString *)fromPath toAudio:(NSString *)toPath outputPath:(NSString *)outputPath{
    
    //1. 获取两个音频源   音频源格式可以mp3格式
    AVURLAsset *asset1 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:fromPath]];
    AVURLAsset *asset2 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:toPath]];
    
    
    
    //2. 获取两个音频源的音频轨道素材
    AVAssetTrack *track1 = [asset1 tracksWithMediaType:AVMediaTypeAudio].firstObject;
    AVAssetTrack *track2 = [[asset2 tracksWithMediaType:AVMediaTypeAudio] firstObject];
    

    
    // 3. 创建一个合成器, 并且在合成器里面追加一个可以编辑的轨道容器
    // AVMutableComposition 继承与AVAssetTrack
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableCompositionTrack *track = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
    
    
    
    // 4. 往轨道容器里面, 添加不同的音频轨道素材
    [track insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset2.duration) ofTrack:track2 atTime:kCMTimeZero error:nil];
    
    [track insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset1.duration) ofTrack:track1 atTime:asset2.duration error:nil];
    
    
    // 5. 导出音频
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
    // 输入文件可以为mp3格式
    //导出文件暂时不支持其它导出的格式 只支持 m4a
    session.outputFileType = AVFileTypeAppleM4A;
    session.outputURL = [NSURL fileURLWithPath:outputPath];
     session.shouldOptimizeForNetworkUse = YES;   //优化网络
    [session exportAsynchronouslyWithCompletionHandler:^{
        //在主线程中导出的
        
        NSLog(@"\n\n\n%@\n\n\n\n", [NSThread currentThread]);
        
        
        AVAssetExportSessionStatus status = session.status;
        
        if (status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"导出成功");
        }
    }];
    
  
}


+(void)cutAudio:(NSString *)audioPath fromTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime outputPath:(NSString *)outputPath{
    
    // 1.获取音频源
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:audioPath]];
    
    
    // 2.创建一个音频会话， 并且相应的配置
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
    session.outputFileType = AVFileTypeAppleM4A;
    session.outputURL = [NSURL fileURLWithPath:outputPath];
    session.shouldOptimizeForNetworkUse = YES;   //优化网络

    CMTime startTime = CMTimeMake(fromTime, 1);
    CMTime endtime= CMTimeMake(toTime, 1);
    session.timeRange = CMTimeRangeFromTimeToTime(startTime, endtime);
    
    // 3.导出
    [session exportAsynchronouslyWithCompletionHandler:^{
        AVAssetExportSessionStatus status = session.status;
        if (status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"导出成功");
        }
        
        
    }];
    
    
    
}






















































@end
