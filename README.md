# Rippl - A Social Media App

Rippl is a social media app that allows users to share their photos and videos
with other users. Users can also follow other users and like and comment on
their posts.

[![Downloads](https://img.shields.io/github/downloads/nixrajput/social-media-app-flutter/total?style=social)][releases]
[![Stars](https://img.shields.io/github/stars/nixrajput/social-media-app-flutter?style=social)][repo]
[![Forks](https://img.shields.io/github/forks/nixrajput/social-media-app-flutter?style=social)][repo]
[![GitHub watchers](https://img.shields.io/github/watchers/nixrajput/social-media-app-flutter?style=social)][repo]
[![GitHub followers](https://img.shields.io/github/followers/nixrajput?style=social)][github]
[![Contributors](https://img.shields.io/github/contributors/nixrajput/social-media-app-flutter?style=social)][repo]

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/nixrajput/social-media-app-flutter?style=social)][releases]
[![GitHub last commit](https://img.shields.io/github/last-commit/nixrajput/social-media-app-flutter?style=social)][repo]
[![GitHub issues](https://img.shields.io/github/issues/nixrajput/social-media-app-flutter?style=social)][issues]
[![GitHub pull requests](https://img.shields.io/github/issues-pr/nixrajput/social-media-app-flutter?style=social)][pulls]
[![GitHub Licence](https://img.shields.io/github/license/nixrajput/social-media-app-flutter?style=social)][license]

- The app is developed using Flutter and GetX state management. The app is
currently in development and is not yet ready for production.

- Right now, the app is only available for Android devices.

- We are open to contributions. If you would like to contribute, please read the
[contribution guidelines](CONTRIBUTING.md).

- We are also looking for UI/UX designers. If you would like to contribute as a UI/UX designer,
please read the [contribution guidelines](CONTRIBUTING.md) and then contact the project [owner][github].

- We are also open to design suggestions. If you would like to suggest a design, feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues).

- We are also open to feature requests. If you would like to request a feature, please feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues). We will try to implement the feature as soon as possible.

- We are also open to bug reports. If you would like to report a bug, please feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues). We will try to fix the bug as soon as possible.

## Setup

- Create `secrets.dart` file in constants folder.
- Add the following code to the file.

```dart
abstract class AppSecrets {
  static const uploadPreset = 'XXX-XXX-XXX-XXX';
  static const cloudinaryCloudName = 'XXX-XXX-XXX-XXX';
  static const githubToken = 'XXX-XXX-XXX-XXX';
}
```

- Replace XXX-XXX-XXX-XXX with your values in the file.
- Now run the following commands:

```dart
flutter clean
flutter pub get packages
```

## Screenshots

Created with [previewed.app](https://previewed.app).

### Row `1`

<img src='screenshots/image1.png' height='720' align='left' alt='Welcome Screen' title='Welcome Screen'>

<img src='screenshots/image2.png' height='720' alt='Login Screen' title='Login Screen'>

### Row `2`

<img src='screenshots/image3.png' height='720' align='left' alt='About Screen' title='About Screen'>

<img src='screenshots/image4.png' height='720' alt='Home Screen' title='Home Screen'>

### Row `3`

<img src='screenshots/image5.png' height='720'  alt='Profile Screen' title='Profile Screen'>

## Download

You can download the app from the [releases page][releases].

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of
conduct, and the process for submitting pull requests to us.

## Authors

- **[Nikhil Rajput][portfolio]** - *Owner & Lead Developer*

## Features

- [x] User Authentication
- [x] Post Feed
- [x] Post Creation
- [x] Post Editing
- [x] Post Deletion
- [x] Post Liking
- [x] Post Commenting
- [ ] Post Sharing
- [x] Post Searching
- [ ] Post Filtering
- [ ] Post Sorting
- [ ] Post Reporting
- [ ] Post Blocking
- [ ] Post Muting
- [x] Profile Creation
- [x] Profile Editing
- [x] Profile Deactivation
- [x] User Following
- [x] User Unfollowing
- [ ] User Blocking
- [ ] User Muting
- [x] User Searching
- [ ] User Filtering
- [x] Trending Posts
- [ ] Hashtag Searching
- [ ] Post Tagging
- [ ] User Mentioning
- [x] Recommendations
- [ ] Search Suggestions
- [x] Settings
- [x] Support
- [x] Dynamic Theme
- [x] P2P Messaging
- [x] Push Notifications

## Upcoming Features

- [ ] Group Messaging
- [ ] Group Creation
- [ ] Post Sharing
- [ ] Post and Chat Settings
- [ ] End-to-End Encryption

## License

This project is licensed under the GPL-3.0 License - see the
[LICENSE.md](LICENSE.md) file for details.

## Activities

![Alt](https://repobeats.axiom.co/api/embed/e86f92199e9d903eba60dadebd6f780fda7c5815.svg "Repobeats analytics image")

## Connect With Me

[![Instagram: nixrajput](https://img.shields.io/badge/-nixrajput-blue?style=social&logo=Instagram&link=https://www.instagram.com/nixrajput/)][instagram]
[![Linkedin: nixrajput](https://img.shields.io/badge/-nixrajput-blue?style=social&logo=Linkedin&link=https://www.linkedin.com/in/nixrajput/)][linkedin]
[![GitHub: nixrajput](https://img.shields.io/badge/-nixrajput-blue?style=social&logo=Github&link=https://www.github.com/nixrajput/)][github]
[![Twitter: nixrajput07](https://img.shields.io/badge/-nixrajput07-blue?style=social&logo=Twitter&link=https://www.twitter.com/nixrajput07/)][twitter]
[![Facebook: nixrajput07](https://img.shields.io/badge/-nixrajput07-blue?style=social&logo=Facebook&link=https://www.facebook.com/nixrajput07/)][facebook]
[![Website: nixlab.co.in](https://img.shields.io/badge/-nixlab.co.in-blue?style=social&logo=Google-Chrome&link=https://www.nixlab.co.in/)][website]

[github]: https://github.com/nixrajput
[website]: https://nixlab.co.in
[facebook]: https://facebook.com/nixrajput07
[twitter]: https://twitter.com/nixrajput07
[instagram]: https://instagram.com/nixrajput
[linkedin]: https://linkedin.com/in/nixrajput
[portfolio]: https://nixrajput.nixlab.co.in
[releases]: https://github.com/nixrajput/social-media-app-flutter/releases
[repo]: https://github.com/nixrajput/social-media-app-flutter
[issues]: https://github.com/nixrajput/social-media-app-flutter/issues
[license]: https://github.com/nixrajput/social-media-app-flutter/blob/master/LICENSE.md
[pulls]: https://github.com/nixrajput/social-media-app-flutter/pulls
