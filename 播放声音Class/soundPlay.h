//
//  soundPlay.h
//  CloudRiding
//
//  Created by luhong on 2022/5/5.
//  Copyright © 2022 List. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface soundPlay : NSObject

///播放本地音效
+(void)playWithLocalSoundName:(NSString *)soundName;
///销毁音效id
+(void)disposeWithLocalSoundName:(NSString *)soundName;

///播放音乐
+(void)playWithMusicName:(NSString *)musicName;
///暂停音乐
+(void)pauseWithMusicName:(NSString *)musicName;
///停止音乐
+(void)stopWithMusicName:(NSString *)musicName;

@end

NS_ASSUME_NONNULL_END
