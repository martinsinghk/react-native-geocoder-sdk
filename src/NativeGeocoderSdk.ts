import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  reverseGeocodeLocation(coordinates: {
    latitude: number;
    longitude: number;
  }): Promise<any>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('GeocoderSdk');
