# final_app1

A new Flutter project.

## Getting Started

Project Architecture:

- Main.dart: The file contains front end UI including App Bar and body which reposible for displaying data from the local database.
- we have services folder, in the folder we have db_service and api_service files. db_service responsible for the local database creation, insertion, deletion of the table data. api_service is responsible for the API data that is coming from the GitHub API.
- we have models folder, in that I created repo_model file which contains all the model information that is identify for the API response structure.

App UI:

- App Bar contains the project name and refresh button which responsible for the data refresh
- In the body, The displayed data stored in the local database which the data is fetched from the API.

App installation: 

- Firstly, enable the unknown source, for that open your settings in your android and search unknown source. enable the “Install unknown Apps”.
- go to the folder, there is a file called app-release.apk, download and install manually into android. if there is no app please run the following command on termainal for the apk file flutter build apk --release
after that you can check in the following directory <your_flutter_project>/build/app/outputs/flutter-apk/app-release.apk for the APK to install on your device.

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
