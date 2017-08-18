//
//  LameTool.m
//  录音功能
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "LameTool.h"
#import "lame.h"
@implementation LameTool

+(NSString *)audioToMp3:(NSString *)sourcePath isDeleteSourceFile:(BOOL)isDelete{
    //输入路径
    NSString *inPath = sourcePath;
    
    // 判断输入路径是否存在
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:sourcePath]) {
        NSLog(@"文件不存在");
    }
    
    // 输入路径
    NSString *outPath = [[sourcePath stringByDeletingPathExtension] stringByAppendingString:@".mp3"];
    
    @try {
        int read,  write;
        //source 被转换的音频文件位置
        
//     rb   打开一个二进制文件，文件必须存在，只允许读
        FILE *pcm = fopen([inPath cStringUsingEncoding:1], "rb");
        // skip file header
        fseek(pcm, 4*1024, SEEK_CUR);
        
//      wb  新建一个二进制文件，已存在的文件将被删除，只允许写
        FILE *mp3 = fopen([outPath cStringUsingEncoding:1], "wb");
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        
        // 11025.0是音频的采样率需要对应
        lame_set_in_samplerate(lame, 11025);
        
        lame_init_params(lame);
        
        do {
            
            size_t size = (size_t)(2*sizeof(short int));
            read = (int)fread(pcm_buffer, size, PCM_SIZE, pcm);
            if (read == 0) {
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            }else{
                
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            }
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@", [exception description]);
        
    } @finally {
        
        NSLog(@"Mp3生成成功:");

        if (isDelete) {
            
            NSError *error;
            [fm removeItemAtPath:sourcePath error:&error];
            
            if (error == nil) {
                NSLog(@"删除源文件成功");
            }
            
        }
        return outPath;
    }

}

 


@end
