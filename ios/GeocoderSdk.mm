#import "GeocoderSdk.h"
#import <CoreLocation/CoreLocation.h>

@implementation GeocoderSdk
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(reverseGeocodeLocation:(NSDictionary *)coordinates
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    CLLocationDegrees latitude = [coordinates[@"latitude"] doubleValue];
    CLLocationDegrees longitude = [coordinates[@"longitude"] doubleValue];
    CLLocation *locationObj = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locationObj completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            reject(@"error", error.localizedDescription, error);
        } else if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
          resolve(@{
                          @"name": placemark.name ?: [NSNull null],
                          @"thoroughfare": placemark.thoroughfare ?: [NSNull null],
                          @"locality": placemark.locality ?: [NSNull null],
                          @"country": placemark.country ?: [NSNull null],
                          @"region": placemark.region ?: [NSNull null],
                          @"timezone": placemark.timeZone ?: [NSNull null],
            });
        } else {
            reject(@"not_found", @"No placemarks found", nil);
        }
    }];
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeGeocoderSdkSpecJSI>(params);
}
#endif

@end
