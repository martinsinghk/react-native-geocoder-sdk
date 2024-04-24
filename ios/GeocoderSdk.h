
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNGeocoderSdkSpec.h"

@interface GeocoderSdk : NSObject <NativeGeocoderSdkSpec>
#else
#import <React/RCTBridgeModule.h>

@interface GeocoderSdk : NSObject <RCTBridgeModule>
#endif

@end
