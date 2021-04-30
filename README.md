# ChatyApp - Chat application with authentication

Flutter application for chatting with your friends.

## About

This application uses Firebase authentication as a service for authenticating and creating users. Authentication is done with Firebase's Flutter package firebase_auth. It provides a Stream object that yields data about the authentication state of the user. The first part of the application, which is authentication, is done and chatting with other people is not yet implemented. State management used in this project is Provider with ChangeNotifier.

## Used packages

* [firebase_auth](https://pub.dev/packages/firebase_auth)
* [provider](https://pub.dev/packages/provider)

## Setup

  1. Clone the repository using the link below:
  ```
  https://github.com/kforjan/chaty-app.git
  ```
  2. Go to the project root and execute the following commands:
  ```
  flutter pub get
  flutter run
  ```

## Preview
Creating a new user          |  Login with an existing user
:-------------------------:|:-------------------------:
![Creating a new user preview](https://s3.gifyu.com/images/registration-chaty.gif)  |  ![Login with an existing user preview](https://s3.gifyu.com/images/login-chaty.gif)
**Invalid password or non-existing account**            |
![Invalid password or non-existing account preview](https://s3.gifyu.com/images/wronguserorpassword-chaty.gif)
