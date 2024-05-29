#import "GeocoderSdk.h"
#import <CoreLocation/CoreLocation.h>

@implementation GeocoderSdk
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(
                  reverseGeocodeLocation:(NSDictionary *)coordinates
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
) {
    CLLocationDegrees latitude = [coordinates[@"latitude"] doubleValue];
    CLLocationDegrees longitude = [coordinates[@"longitude"] doubleValue];
    CLLocation *locationObj = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // https://developer.apple.com/documentation/corelocation/clplacemark?language=objc
    [geocoder reverseGeocodeLocation:locationObj completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            reject(@"Error", error.localizedDescription, error);
            return;
        }
        
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            resolve(@{
                // location
                // @"location": CLLocation?
                @"region": placemark.region ?: [NSNull null],
                // name
                @"name": placemark.name ?: [NSNull null],
                // details
                @"thoroughfare": placemark.thoroughfare ?: [NSNull null],
                @"subThoroughfare": placemark.subThoroughfare ?: [NSNull null],
                @"locality": placemark.locality ?: [NSNull null],
                @"subLocality": placemark.subLocality ?: [NSNull null],
                @"administrativeArea": placemark.administrativeArea ?: [NSNull null],
                @"subAdministrativeArea": placemark.subAdministrativeArea ?: [NSNull null],
                @"postalCode": placemark.postalCode ?: [NSNull null],
                // country
                @"isoCountryCode": placemark.ISOcountryCode ?: [NSNull null],
                @"country": placemark.country ?: [NSNull null],
                // associated contact details
                // @"postalAddress": CNPostalAddress?
                // langscape information
                @"inlandWater": placemark.inlandWater ?: [NSNull null],
                @"ocean": placemark.ocean ?: [NSNull null],
                // points of interest
                // @"areasOfInterest": [String]?
                // time zone
                @"timezone": placemark.timeZone ?: [NSNull null],
            
            });
            return;
        }
        
        reject(@"Error", @"No placemarks found", nil);
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
