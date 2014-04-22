//
//  DeviceAudioServiceAudioItem.m
//
//  Created by Conzentrate.
//
//

#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface DeviceAudioServiceAudioItem : NSObject {
	CDVInvokedUrlCommand	*invokedUrlCommand;
	NSString				*theId;
	NSURL					*theUrl;
	AVPlayer				*thePlayer;
}
@property (readwrite) NSObject <CDVCommandDelegate> *commandDelegate;
@property (readwrite) BOOL isPaused;

- (void)addAudioWithInvokedUrlCommand:(CDVInvokedUrlCommand *)command;
- (void)play;
- (void)pause;
- (BOOL)shouldResumePlayback;

@end
