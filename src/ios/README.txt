DeviceAudioService plugin for PhoneGap/Apache Cordova
Developed by Conzentrate ApS - http://conzentrate.com

THIS SOFTWARE IS PROVIDED BY CONZENTRATE APS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL CONZENTRATE APS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The DeviceAudioService is designed to enable simultaneous playback of multiple Url based audio sources from within PhoneGap applications, via a simple API.

Getting started:
Add the following files to your PhoneGap Plugins directory (and add to XCode Project):
DeviceAudioService.h
DeviceAudioService.m
DeviceAudioServiceAudioItem.h
DeviceAudioServiceAudioItem.m

Add the following file to your www directory, and add to index.html:
DeviceAudioService.js

Note: If you are using automated reference counting (ARC), you may need to remove retain/release statements.

Usage:
You may call each of the API methods below by using the following template:
	cordova.exec(
		// Register the callback handler
		function(data) {
			// Stuff to do on successfull callback
		},
		// Register the errorHandler
		function(err) {
			// Stuff to do when an error occurs.
		},
		'DeviceAudioService',
		'AN_API_METHOD',
		[ 'ONE_OR_MORE_PARAMETERS_TO_PASS_TO_THE_METHOD' ]
	);


1) Use the addAudioWithIdAndUrl() method to preload one or more audio files
   Note: Make sure to wait for phonegap deviceready event before atteptimpting to load assets
2) Play and/or pause audio asset(s) via the playAudioWithId and pauseAudioWithId methods. 
3) When done, purge the preloaded audio files via the removeAllAudio method

API methods:
addAudioWithIdAndUrl: function ( anId, aUrl, aSuccessCallback, aFailureCallback )
	params: anId - a unique string identifier referencing the audio file
			aUrl - the Url to the audio file to be preloaded. The file will be played back via the AVPlayer iOS Class
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			The method will call the success callback when the iOS Cocoa AVPlayerStatusReadyToPlay status is triggered. Before attempting to play back the audio file You should wait for the success callback. The method will call the failure callback when the AVPlayerStatusFailed is triggered.
			
playAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
	params: anId - a unique string identifier referencing the audio file
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			Plays an audio file previously preloaded via the method addAudioWithIdAndUrl
		
pauseAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
	params: anId - a unique string identifier referencing the audio file
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			Pauses an audio file previously preloaded via the method addAudioWithIdAndUrl
		
audioWithIdIsPaused: function (anId, aSuccessCallback, aFailureCallback) {
	params: anId - a unique string identifier referencing the audio file
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			Tests if an audio file is currently paused. If the audio file has not previously been issued a play command via playAudioWithId this test will fail.
		
audioWithIdShouldResumePlayback: function (anId, aSuccessCallback, aFailureCallback) {
	params: anId - a unique string identifier referencing the audio file
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			Tests if a previously paused audio file should be resumed. The criteria are: If the currentTime of the AVPlayer instance is > 0 and the audio has previously been issued a pauseAudioWithId command the method will return successful.
		
removeAllAudio: function (aSuccessCallback, aFailureCallback) {
	params: anId - a unique string identifier referencing the audio file
			aSuccessCallback - success callback function
			aFailureCallback - error/fail callback function
	detail:	
			Purges all preloaded audio files and empties the dictionary of registered unique id's
			
			
			
