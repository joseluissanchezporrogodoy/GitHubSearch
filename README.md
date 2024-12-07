# GitHubSearch

GitHubSearch is an application available for **iOS**, **iPadOS**, and **tvOS**, supporting all screen orientations. It is built with the MVVM architecture, leveraging use cases and adhering to the SOLID principles. The app includes unit tests, UI tests, and utilizes **SwiftLint** for static code analysis to maintain clean and consistent code.

## Features

- **Multi-Platform Support:** Available for **iOS**, **iPadOS**, and **tvOS**, supporting all screen orientations.
- **Search Screen:** 
  - A text field and search button to input a GitHub username.
  - On successful search, navigates to a detail view showing:
    - User's avatar.
    - List of repositories associated with the profile.
  - Handles errors:
    - **User Not Found:** Displays an alert when the user doesn't exist.
    - **Network Error:** Displays an alert when there is an issue with the network.
  - Offline mode: A full-screen overlay warns the user that the app cannot work without an internet connection.

## Architecture

The app is designed with the **MVVM** architecture and follows **SOLID** principles to ensure maintainability and scalability. 

### Key Components

1. **Use Cases:** Business logic is encapsulated into use cases for clear separation of concerns.
2. **GitHubNetworking:** A custom **Swift Package** created specifically for this app to handle network requests.
3. **Static Analysis:** **SwiftLint** is used to enforce code quality and consistency.

## Testing

- **Unit Tests:** To verify the correctness of business logic and use cases.
- **UI Tests:** To ensure the application behaves as expected in real-world scenarios.

## Dependencies

- **[GitHubNetworking](#):** A custom Swift Package Manager dependency to handle communication with the GitHub API.

## Getting Started

### Prerequisites

- Xcode 15 or later
- Swift 5.9
- Internet connection

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/GitHubSearch.git
   ```
2.	Open the project in Xcode:
   ```bash
   cd GitHubSearch
   open GitHubSearch.xcodeproj
   ```
3.	Build and run the app on a simulator or device.

## Screenshots

Search Screen
![Simulator Screenshot - iPhone 16 Pro - 2024-12-07 at 11 12 37](https://github.com/user-attachments/assets/1b368627-ec73-42de-ac11-a9a21960ae90)


Detail Screen

![Simulator Screenshot - iPhone 16 Pro - 2024-12-07 at 11 13 22](https://github.com/user-attachments/assets/97335dc8-0502-421a-9ad7-70fc27ab4e9a)

User not found Alert

![Simulator Screenshot - iPhone 16 Pro - 2024-12-07 at 11 12 57](https://github.com/user-attachments/assets/b0d11333-ebfa-4965-a6be-ae8de991b9a0)

Offline Warning

![IMG_408D72FF0082-1](https://github.com/user-attachments/assets/c8cb8b3d-dd05-4d34-b468-1339cfc489db)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
