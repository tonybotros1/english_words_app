# My Words

My Words is a Flutter vocabulary card app for saving English words with Arabic meanings, notes, favourites, text-to-speech, and a quick memory quiz.

## Features

- Add, edit, delete, search, and favourite vocabulary cards
- Listen to English and Arabic pronunciations
- Quiz yourself with saved words
- Switch between system, light, and dark themes
- Store words locally with SQLite

## Run

```sh
flutter pub get
flutter run
```

## Test

```sh
flutter analyze
flutter test
```

## Android Release Signing

Create `android/key.properties` from `android/key.properties.example`, then point `storeFile` to your upload keystore before building a release APK or app bundle.
