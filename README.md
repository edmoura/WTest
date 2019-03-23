### What is this repository for? ###

* WTest
* 1.0

### How do I get set up? ###

[CocoaPods](https://cocoapods.org). All you need to setup it properly is:
* run pod install

### About the project ###

* Schemes instead of a target

  App has three different schemes, Production, Development and Homolog, anyone can be selected into Xcode and each scheme shows a different website on tab bar 04.
  
  For all schemes, app consumes one .plist. The URLs, version, bundle id and Names are config on the main .plist. [BUILD_NUMBER, BUNDLE_ID, BUNDLE_NAME, ENDPOINT].

* Viper as Design Pattern
  V — View, I — Interactor, P — Presenter, E — Entity, R — Router
  
  View — Responsibility of view is to send user actions to the presenter and show whatever the presenter asks it to.
  
  Interactor — It has the business logic for the app specified by a use case.
  
  Presenter — Contains the view logic for preparing content for display and for reacting to user interactions.
  
  Entity — The Basic model for objects used by interaction.
  
  Router — Contains logic for routing of screens.
