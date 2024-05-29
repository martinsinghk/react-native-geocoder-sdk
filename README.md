# react-native-geocoder-sdk

This module aims at bridging the mobile Geocoder SDK into React Native.

## Installation

```sh
yarn add react-native-geocoder-sdk
```

## Usage

```js
import { reverseGeocodeLocation } from 'react-native-geocoder-sdk';

// ...

const location = await reverseGeocodeLocation({
  latitude: 37.785834,
  longitude: -122.406417,
});

/*
iOS response sample
{
   "administrativeArea":"CA",
   "areasOfInterest":null,
   "country":"美國",
   "inlandWater":null,
   "isoCountryCode":"US",
   "locality":"舊金山",
   "location":{
      "altitude":null,
      "coordinate":{
         "latitude":37.785834,
         "longitude":-122.406417
      },
      "course":-1,
      "horizontalAccuracy":100,
      "speed":-1,
      "verticalAccuracy":-1
   },
   "name":"1-99 Stockton St",
   "ocean":null,
   "postalCode":"94108",
   "region":null,
   "subAdministrativeArea":"舊金山",
   "subLocality":"Union Square",
   "subThoroughfare":"1-99",
   "thoroughfare":"Stockton St",
   "timezone":null
}
*/

```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
