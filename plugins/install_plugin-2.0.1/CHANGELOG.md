## 2.0.1

* fix issue 15,17

## 2.0.0

* Breaking change. Migrate from the deprecated original Android Support Library to AndroidX.This shouldn't result in any functional changes, but it requires any Android apps using this plugin to also migrate if they're using the original support library.

## 1.2.0

* Upgrade kotlin(1.2.71) and gradle build plugin version(3.2.1).

## 1.1.0

* Remove `getPlatformVersion` function.

## 1.0.0

* Add CHANGELOG and README.
* Remove unused code.
* Update plugin homepage url.

## 0.0.2

* Fix the bug that Pixel Device install apk fail.
* Optimize the user experience when app asking for `Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES` permission for Android device above ANDROID.O.

## 0.0.1

* Add `installApk` function for android to install apk, supporting ANDROID.O.
* Add `gotoAppStore` function for iOS to launch a url to App Store.