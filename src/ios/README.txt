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

Please refer to docs/README.md for common usage patterns and API method documentation

