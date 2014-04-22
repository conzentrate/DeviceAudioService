//
//  DeviceAudioService.h
//
//  Created by Conzentrate.
//
//

#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import "DeviceAudioServiceAudioItem.h"

@interface DeviceAudioService : CDVPlugin {
    NSMutableDictionary *registeredAudioElements;
}

- (void)pluginInitialize;
- (void)addAudioWithIdAndUrl:(CDVInvokedUrlCommand *)command;
- (void)playAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)pauseAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)removeAllAudio:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdIsPaused:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdShouldResumePlayback:(CDVInvokedUrlCommand *)command;

@end
