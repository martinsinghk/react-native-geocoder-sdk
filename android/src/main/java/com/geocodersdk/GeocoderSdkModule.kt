package com.geocodersdk

import com.facebook.react.bridge.*
import android.location.Geocoder
import java.io.IOException
import java.util.*

class GeocoderSdkModule internal constructor(context: ReactApplicationContext) :
  GeocoderSdkSpec(context) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  override fun reverseGeocodeLocation(coordinates: ReadableMap, promise: Promise) {
        val latitude = coordinates.getDouble("latitude")
        val longitude = coordinates.getDouble("longitude")
        val geocoder = Geocoder(reactApplicationContext, Locale.getDefault())

        try {
            val addresses = geocoder.getFromLocation(latitude, longitude, 1)
            if (!addresses.isNullOrEmpty()) {
                val address = addresses[0]

                val writableMap = WritableNativeMap()
                writableMap.putString("addressLine", address.getAddressLine(0))
                writableMap.putString("locality", address.locality)
                writableMap.putString("countryName", address.countryName)
                writableMap.putString("countryCode", address.countryCode)

                promise.resolve(writableMap)
            } else {
                promise.reject("NOT_FOUND", "No address found for the given coordinates")
            }
        } catch (e: IOException) {
            promise.reject("ERROR", e.message, e)
        }
  }

  companion object {
    const val NAME = "GeocoderSdk"
  }
}
