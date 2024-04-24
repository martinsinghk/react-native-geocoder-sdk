package com.geocodersdk

import com.facebook.react.bridge.*

abstract class GeocoderSdkSpec internal constructor(context: ReactApplicationContext) :
  ReactContextBaseJavaModule(context) {

  abstract fun reverseGeocodeLocation(coordinates: ReadableMap, promise: Promise)
}
