# Currency Converter Application 🪙

A Flutter-based **Currency Converter Application** that allows users to seamlessly convert between different currencies. The app is designed with responsive UI, state management using `flutter_bloc`, and optimized for various devices using the `responsive_sizer` package.

---

## Features ✨

- **Dynamic Currency Loading**: Fetch and display available currencies using APIs.
- **Responsive Design**: Ensures a smooth experience on devices of all sizes.
- **State Management**: Powered by the robust `flutter_bloc` architecture.
- **Persistent Data**: Saves user preferences locally using `shared_preferences`.
- **Environment Management**: Manage sensitive data securely using `.env` files.

---

## Project Setup 🚀

### Prerequisites

- Flutter SDK version `3.5.2` or higher
- Dart version compatible with Flutter `3.5.2`
- A valid API key (stored in `.env` file)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/dinethsiriwardana/currency_converter_application.git
   cd currency_converter_application
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the project root and add your API key:

   ```
   API_KEY=your_api_key_here
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## Packages Used 📦

| Package              | Purpose                                     |
| -------------------- | ------------------------------------------- |
| `flutter_bloc`       | State management                            |
| `shared_preferences` | Persistent storage for user preferences     |
| `dio`                | HTTP client for API communication           |
| `flutter_dotenv`     | Secure environment configuration            |
| `responsive_sizer`   | Responsive layouts based on screen size     |
| `flutter_lints`      | Linting and enforcing best coding practices |

---

## Folder Structure 🗂

```
lib/
├── bloc/                     # State management logic
├── repository/               # Data fetching and processing
├── screens/                  # UI screens
├── theme.dart                # Application themes
└── main.dart                 # Application entry point
```

---

## Contribution 🤝

Contributions are welcome! Feel free to submit issues or pull requests.

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Add a meaningful commit message"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.

---

## License 📄

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Screenshots 📷

<!-- Syntax: <img src="URL" alt="Description" width="Width in px"> -->
<img src="https://github.com/user-attachments/assets/38fdcbbc-0415-49e6-9f64-b84d58505e2d" alt="Simulator Screenshot 1" width="200">
<img src="https://github.com/user-attachments/assets/cf3b023b-a220-49fe-916a-9e47377b75f8" alt="Simulator Screenshot 2" width="200">
<img src="https://github.com/user-attachments/assets/16a24c26-497d-4208-8042-abe44f2755c4" alt="Simulator Screenshot 3" width="200">
<img src="https://github.com/user-attachments/assets/8711db2c-3bd7-4760-b7d4-4d4137ff5c33" alt="Simulator Screenshot 4" width="200">



---

Happy coding! 💻
