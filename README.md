# flutter_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android
## Run the following from the top of your Flutter project to get the size of APK for 32-bit Android devices:

flutter build apk --target-platform=android-arm
## The output should look something like the following:
Built build/app/outputs/apk/release/app-release.apk (4.2MB).

## For 64-bit Android devices, run the following:
flutter build apk --target-platform=android-arm64
## Here is an example output:
Built build/app/outputs/apk/release/app-release.apk (4.6MB).

## You can run the following to get 2 APKs, one for 32-bit and one for 64-bit:
flutter build apk --split-per-abi
## Here’s some sample output:
Built build/app/outputs/apk/release/app-armeabi-v7a-release.apk (4.2MB).
Built build/app/outputs/apk/release/app-arm64-v8a-release.apk (4.6MB).

## 状态管理使用
pub run build_runner build

## 如果报错无效请运行 
flutter packages pub run build_runner build

## 如果要在进行更改时使其在后台运行，请使用：
pub run build_runner watch