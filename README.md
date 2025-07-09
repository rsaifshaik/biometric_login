# Biometric Login App (Flutter)

This project demonstrates a Flutter-based mobile application that implements **biometric authentication** (fingerprint) along with **email/password login**. It's built as part of an assignment to enhance security and user experience.

---

## 🔐 Features

- Fingerprint biometric login using `local_auth`
- Email and password fallback login
- Secure token storage using `flutter_secure_storage`
- Fallback UI in case device does not support biometrics
- Clean, responsive login UI
- Navigation to home screen after login

---

## 📱 Screens

1. **Login Screen**
    - Email & Password input
    - Fingerprint icon to trigger biometric authentication

2. **Home Screen**
    - Simple welcome screen with a logout option

---

## 🛠️ Technologies Used

- **Flutter**
- **Dart**
- **local_auth** – for biometric authentication
- **flutter_secure_storage** – for securely storing tokens
- **Material Design**

---

## 📦 Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  local_auth: ^2.1.7
  flutter_secure_storage: ^9.0.0
