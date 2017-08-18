//
//  YBAudioTool.h
//  录音功能
//
//  Created by yanbo on 17/8/17.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sington.h"
#import <AVFoundation/AVFoundation.h>

typedef void(^Success) (BOOL ret);

@interface YBAudioTool : NSObject
singtonInterface;

/**
 *  开始录音
 */
- (void)beginRecordWithRecordPath: (NSString *)recordPath;
/**
 *  结束录音
 */
- (void)endRecord;
/**
 *  暂停录音
 */
- (void)pauseRecord;

/**
 *  删除录音
 */
- (void)deleteRecord;

/**
 *  重新录音
 */
- (void)reRecord;


/**
 *  录音文件路径
 */
@property (nonatomic, copy, readonly) NSString *recordPath;


- (void)updateMeters;

- (float)peakPowerForChannel0;

@end
