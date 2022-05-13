//
//  soundPlay.m
//  CloudRiding
//
//  Created by luhong on 2022/5/5.
//  Copyright © 2022 List. All rights reserved.
//

#import "soundPlay.h"
#import <AVFoundation/AVFoundation.h>

@implementation soundPlay

static NSMutableDictionary *_soundDict;

static NSMutableDictionary *_playerDict;

+(NSMutableDictionary *)soundDict
{
    if (!_soundDict) {
        _soundDict = [NSMutableDictionary dictionary];
    }
    return _soundDict;
}

+(NSMutableDictionary *)playerDict
{
    if (!_playerDict) {
        _playerDict = [NSMutableDictionary dictionary];
    }
    return _playerDict;
}
///播放音效
+(void)playWithLocalSoundName:(NSString *)soundName
{
    if (soundName == nil) return;
    
    //从数组中取得soundId
    SystemSoundID soundId = [[self soundDict][soundName] unsignedIntValue];
    
    //如果数组中soundId不存在,就要从新创建然后添加到数组里
    if (!soundId) {
        
        //获取工程中播放音效的路径
        NSURL *url = [[NSBundle mainBundle]URLForResource:soundName withExtension:nil];
        
        //如果该路径不存在,返回
        if (!url) return;
        
        //创建soundId
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundId);//创建soundId
        
        //将soundId存储到数组中
        [self soundDict][soundName] = @(soundId);
    }
    
    //播放音效
    AudioServicesPlaySystemSound(soundId);
//    AudioServicesPlayAlertSound(soundId)//带振动效果
}
///销毁音效
+(void)disposeWithLocalSoundName:(NSString *)soundName
{
    if (soundName == nil) return;
    
    //从数组中取得soundId
    SystemSoundID soundId = [[self soundDict][soundName] unsignedIntValue];
    
    //如果soundId存在就销毁
    if (soundId) {
        
        //销毁音效id
        AudioServicesDisposeSystemSoundID(soundId);
        
        //从数组中移除该文件
        [[self soundDict]removeObjectForKey:soundName];
    }
}

///播放音乐
+(void)playWithMusicName:(NSString *)musicName
{
    AVAudioPlayer *player = nil;
    
    if (musicName == nil) return;
    
    player = [self playerDict][musicName];
    
    if (!player) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
        if (!url) return;
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [player prepareToPlay];
        [[self playerDict] setValue:player forKey:musicName];
    }
    [player play];
}
///暂停音乐
+(void)pauseWithMusicName:(NSString *)musicName
{
    AVAudioPlayer *player = [self playerDict][musicName];
    if (player) {
        
        [player pause];
    }
}

///停止音乐
+(void)stopWithMusicName:(NSString *)musicName
{
    AVAudioPlayer *player = [self playerDict][musicName];
    if (player) {
        [player stop];
        [[self playerDict]removeObjectForKey:musicName];
        player = nil;
    }
}

@end
