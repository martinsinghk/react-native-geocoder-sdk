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
  latitude: latitude,
  longitude: longitude,
});

/*
iOS response format
{
  "administrativeArea":"CA",
  "country":"美國",
  "inlandWater":null,
  "isoCountryCode":"US",
  "locality":"舊金山",
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
