## Setup Instructions for Firebase

This project uses Firebase for backend services. To run this project locally, you need to configure Firebase with your own credentials.

## Steps:

    Install Firebase CLI: Make sure you have the Firebase CLI installed and set up.

    Generate Firebase Configuration: Run the following command in your terminal to generate the firebase_options.dart file:

flutterfire configure

## Follow the prompts to link your Firebase project.

Place the Configuration File: Once generated, place the firebase_options.dart file in the lib directory of the project:

lib/firebase_options.dart

## Run the Project: Use the following command to run the project:

    flutter run

## Note:

The firebase_options.dart file contains sensitive API keys and should not be committed to version control. It is included in the .gitignore file for security.