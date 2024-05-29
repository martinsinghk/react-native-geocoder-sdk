import CoreLocation

@objc(GeocoderSdk)
class GeocoderSdk: NSObject {
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc(reverseGeocodeLocation:resolver:rejecter:)
    func reverseGeocodeLocation(
        coordinates: [String: Any],
        resolver: @escaping RCTPromiseResolveBlock,
        rejecter: @escaping RCTPromiseRejectBlock
    ) {
        guard let latitude = coordinates["latitude"] as? CLLocationDegrees else {
            rejecter("error", "Invalid latitude", nil)
            return
        }
        guard let longitude = coordinates["longitude"] as? CLLocationDegrees else {
            rejecter("error", "Invalid longitude", nil)
            return
        }
        
        let locationObj = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        // https://developer.apple.com/documentation/corelocation/clplacemark
        geocoder.reverseGeocodeLocation(locationObj) { (placemarks, error) in
            if let error = error {
                rejecter("error", error.localizedDescription, error)
                return
            }
            if let placemark = placemarks?.first {
                resolver([
                    // location
                    // "location": CLLocation?
                    "region": placemark.region ?? NSNull(),
                    // name
                    "name": placemark.name ?? NSNull(),
                    // details
                    "thoroughfare": placemark.thoroughfare ?? NSNull(),
                    "subThoroughfare": placemark.subThoroughfare ?? NSNull(),
                    "locality": placemark.locality ?? NSNull(),
                    "subLocality": placemark.subLocality ?? NSNull(),
                    "administrativeArea": placemark.administrativeArea ?? NSNull(),
                    "subAdministrativeArea": placemark.subAdministrativeArea ?? NSNull(),
                    "postalCode": placemark.postalCode ?? NSNull(),
                    // country
                    "isoCountryCode": placemark.isoCountryCode ?? NSNull()
                    "country": placemark.country ?? NSNull(),
                    // associated contact details
                    // "postalAddress": CNPostalAddress?
                    // langscape information
                    "inlandWater": placemark.inlandWater ?? NSNull(),
                    "ocean": placemark.ocean ?? NSNull(),
                    // points of interest
                    // "areasOfInterest": [String]?
                    // time zone
                    "timezone": placemark.timeZone?.identifier ?? NSNull(),
                
                ])
                return
            }
            
            rejecter("error", "No placemarks found", nil)
        }
    }

    // Don't compile this code when we build for the old architecture.
    #if RCT_NEW_ARCH_ENABLED
    @objc
    func getTurboModule(params: [AnyHashable : Any]) -> Any? {
        return NativeGeocoderSdkSpecJSI(params: params)
    }
    #endif
}
