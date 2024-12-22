# Click to Food - Flutter Application

## Overview
Click to Food is a Flutter-based application designed for efficient food ordering and user management. The app follows a clean architecture pattern and leverages Bloc for state management, Dio for HTTP requests, and GoRouter for routing. It also includes dynamic token management with automatic token refresh.

---

## Folder Structure

```
lib/
|– dashboard/
   |– data/
      |– requestfolder/ - Contains data classes for API request payloads.
      |– responsedataclass/ - Contains data classes for API response handling.
   |– domain/
      |– repo/ - Repository interfaces for API communication.
   |– presentation/
      |– bloc/ - Bloc classes for managing application state.
      |– pages/ - UI pages such as Dashboard, Login, etc.
      |– widget/ - Reusable UI components.
|– main.dart - Application entry point.
```

---

## Setup Instructions

1. **Prerequisites:**
    - Install Flutter SDK [Flutter Install Guide](https://docs.flutter.dev/get-started/install).
    - Ensure you have an IDE (e.g., Android Studio or VS Code) with the Flutter plugin installed.
    - Configure a device/emulator for testing.

2. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   cd click_to_food
   ```

3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Set Up API Base URL:**
    - Navigate to `constants.dart` and ensure the API base URL is correctly set:
      ```dart
      static String baseUrl = "https://demo-api.devdata.top/api";
      ```

5. **Run the Application:**
   ```bash
   flutter run
   ```

---

## API Assumptions and Behavior

### Endpoints:
- **Check User Existence**: Verifies if a user exists based on email.
    - URL: `POST /Administrator/CheckUserExists`
- **Login**: Authenticates a user and provides a Bearer token.
    - URL: `POST /Administrator/Login`
- **Send OTP to Email**: Sends a one-time password to the user's email.
    - URL: `POST /Administrator/SendOTPToEmail`
- **Check OTP from Email**: Validates the OTP sent to the email.
    - URL: `POST /Administrator/CheckOTPFromEmail`
- **Register User**: Registers a new user with the provided information.
    - URL: `POST /Administrator/SaveUser`
- **Forgot Password**: Initiates the password reset process by sending an OTP.
    - URL: `POST /Administrator/ForgetPassword`
- **Set New Password**: Updates the user's password.
    - URL: `POST /Administrator/SetPassword`
- **Logout**: Logs out the user and invalidates the token.
    - URL: `POST /Administrator/Logout`
- **Refresh Token**: Automatically refreshes the Bearer token.
    - URL: `POST /Administrator/RefreshToken`

### Behavior:
- Dynamic token refresh ensures the user remains authenticated seamlessly.
- Success dialogs provide feedback after successful operations.
- OTP flow is used for both registration and password recovery.

---

## Running and Testing the Application

1. **Run Locally:**
   ```bash
   flutter run
   ```

2. **Testing API Endpoints:**
    - The app uses Dio for API calls; ensure the API server is active.
    - Test endpoints with tools like Postman to verify responses.

3. **Simulate Token Expiry:**
    - Manually reduce the token expiration time during testing to validate the token refresh mechanism.

---

## State Management

The application uses **Bloc** for state management. Below is a summary of its implementation:

1. **Login Bloc:**
    - Handles user login, validates credentials, and manages token storage.

2. **Dashboard Bloc:**
    - Fetches user-specific data such as categories and popular foods.
    - Manages token refresh logic and logout functionality.

3. **Registration Bloc:**
    - Manages user registration workflow, including OTP validation and data submission.

4. **Password Reset Bloc:**
    - Handles OTP verification and password update logic.

### Bloc Structure:
- **Event:** Represents user actions (e.g., `LoginSubmitted`, `OtpVerified`).
- **State:** Represents the app's state (e.g., `LoginSuccess`, `OtpInvalid`).
- **Bloc:** Converts events into states using business logic.

---

## Application Flow

1. **Splash Screen**: Displays briefly before navigating to the Welcome Screen.
2. **Welcome Screen**: Provides login, registration, and password recovery options.
3. **Login Flow**:
    - Input email.
    - If the user exists, input password and navigate to Dashboard.
    - If the user does not exist, request OTP and proceed to Registration.
4. **Dashboard**:
    - Displays user-specific data with token refresh timer and logout button.
5. **Password Recovery**:
    - Request OTP, verify OTP, set a new password, and return to Login.

---

For further assistance, please refer to the source code comments.

