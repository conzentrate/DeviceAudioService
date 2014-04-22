//
//  DeviceAudioService.m
//
//  Created by Conzentrate.
//
//

#import "DeviceAudioService.h"

@implementation DeviceAudioService

NSString* ERROR_AUDIO_KEY_ALREADY_REGISTERED = @"Error: key already exists";
NSString* ERROR_AUDIO_KEY_NOT_FOUND = @"Error: audio key not found";

NSString* OK_AUDIO_REGISTERED = @"OK: audio registered";
NSString* OK_AUDIO_PLAYING = @"OK: audio playback requested";
NSString* OK_AUDIO_PAUSED = @"OK: audio paused requested";

NSString* STATUS_AUDIO_IS_PAUSED = @"Status: audio is paused";
NSString* STATUS_AUDIO_IS_PLAYING = @"Status: audio is playing";
NSString* STATUS_ALL_AUDIO_REMOVED = @"Status: all audio has been removed";

- (void)pluginInitialize
{
    registeredAudioElements = [[NSMutableDictionary alloc] initWithCapacity:2];
}

- (void)addAudioWithIdAndUrl:(CDVInvokedUrlCommand *)command {
	
    [self.commandDelegate runInBackground:^{

		CDVPluginResult *pluginResult;

		NSString *anId = [command.arguments objectAtIndex:0];
		
		if ([registeredAudioElements valueForKey:anId] != nil) {
			// Provide feedback via a callback that the request vas not successful
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_ALREADY_REGISTERED];
		}
		else
		{
			DeviceAudioServiceAudioItem *anAudioItem = [[DeviceAudioServiceAudioItem alloc] init];
			anAudioItem.commandDelegate = self.commandDelegate;
			[anAudioItem addAudioWithInvokedUrlCommand:command];

			[registeredAudioElements setObject:anAudioItem forKey:anId];

			// Provide feedback via a callback that the request vas successful
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_REGISTERED];

		}

		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        NSLog(@"registeredAudioElements %@",registeredAudioElements);        
        
    }];

}

- (void)playAudioWithId:(CDVInvokedUrlCommand *)command {

	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];
	
	NSLog(@"playAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);

	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] play];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_PLAYING];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)pauseAudioWithId:(CDVInvokedUrlCommand *)command {

	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] pause];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_PAUSED];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)audioWithIdIsPaused:(CDVInvokedUrlCommand *)command {

	NSDictionary *jsonObj;
	NSString *anId = [command.arguments objectAtIndex:0];

	if ([(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:anId] isPaused] == YES) {
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"true", @"isPaused",nil];
	}
	else
	{
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"false", @"isPaused",nil];
	}
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: jsonObj];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)audioWithIdShouldResumePlayback:(CDVInvokedUrlCommand *)command {
	
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];
	NSDictionary *jsonObj;
	
	if ([(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:anId] shouldResumePlayback] == YES) {
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"true", @"shouldResumePlayback",nil];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: jsonObj];
	}
	else
	{
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"false", @"shouldResumePlayback",nil];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary: jsonObj];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)removeAllAudio:(CDVInvokedUrlCommand *)command {

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] pause];
	}
	
	[registeredAudioElements removeAllObjects];

	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:STATUS_ALL_AUDIO_REMOVED];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

	NSLog(@"registeredAudioElements %@",registeredAudioElements);
}


@end
