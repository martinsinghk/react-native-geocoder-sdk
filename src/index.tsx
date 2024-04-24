import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-geocoder-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

// @ts-expect-error
const isTurboModuleEnabled = global.__turboModuleProxy != null;

const GeocoderSdkModule = isTurboModuleEnabled
  ? require('./NativeGeocoderSdk').default
  : NativeModules.GeocoderSdk;

const GeocoderSdk = GeocoderSdkModule
  ? GeocoderSdkModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function reverseGeocodeLocation(coordinates: any): Promise<any> {
  return GeocoderSdk.reverseGeocodeLocation(coordinates);
}
