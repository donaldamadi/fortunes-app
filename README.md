# Running the Application on Android and iOS

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Flutter SDK**: Ensure you have the latest version of Flutter installed. If you haven't installed Flutter yet, visit the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

- **Android Studio or Xcode**: For Android and iOS emulation/simulation respectively. This is required for the Android Emulator and iOS Simulator.
- An IDE or code editor of your choice (VS Code, Android Studio, etc.).

### Setup

1. **Clone the Repository**: Clone the project repository to your local machine using the following command:

    ``` bash
    git clone https://github.com/donaldamadi/fortunes-app.git
    ```

2. **Navigate to the Project Directory**: Use the command line to navigate into the root of the project directory.

    ``` bash
    cd <project-directory>
    ```

    Replace `<project-directory>` with the name of your project's directory.

3. **Get Dependencies**: Run the following command to retrieve the project's dependencies:

    ``` bash
    flutter pub get
    ```

### Running on Android

1. **Open Android Emulator**: Start Android Studio and open the AVD Manager to start your Android emulator. Alternatively, you can connect an Android device to your computer via USB debugging mode.

2. **Run the Application**: Run the following command in the terminal within your project directory:

    ``` bash
    flutter run
    ```

   This command will build the app and install it on the currently running emulator or connected Android device.

### Running on iOS

1. **Open iOS Simulator**: To start the iOS Simulator, open Xcode and navigate to `Xcode > Open Developer Tool > Simulator`. Alternatively, you can connect an iOS device to your computer.

2. **Run the Application**: Before running the application on an iOS device or simulator for the first time, navigate to the `ios` folder within your project directory in the terminal and run:

    ``` bash
    pod install
    ```

   Then, return to the root project directory and run:

    ``` bash
    flutter run
    ```

   This command will build the app and install it on the currently running simulator or connected iOS device.

### Troubleshooting

- If you encounter any issues related to Flutter SDK path not set, ensure you have correctly set up the Flutter SDK path in your environment variables.
- For any device connection issues, verify that your device is properly connected and that USB debugging (for Android) or the device is trusted (for iOS) is enabled.
- If the build fails, check the error log for specifics. It might be due to missing dependencies or configuration issues.

### Additional Notes

- To run the application in release mode, append `--release` to the `flutter run` command.
- For more detailed logging, you can use `flutter run -v` for verbose output.
