# Delete these folders manually or use commands:
rm -rf build/
rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf .dart_tool/
rm -rf pubspec.lock

# Then reinstall
flutter pub get
cd ios && pod install --repo-update
cd ..
flutter run