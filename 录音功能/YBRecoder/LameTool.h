//
//  LameTool.h
//  录音功能
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LameTool : NSObject

+(NSString *)audioToMp3:(NSString *)sourcePath isDeleteSourceFile:(BOOL)isDelete;

@end
