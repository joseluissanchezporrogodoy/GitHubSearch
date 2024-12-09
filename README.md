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

<img src="https://github.com/user-attachments/assets/9d35a81a-8976-4a32-be1d-935d0390626b" alt="Search Screen" width="400"/>

Detail Screen

<img src="https://github.com/user-attachments/assets/c4de938b-6fc8-4bf8-8070-310b2c54280a" alt="Detail Screen" width="400"/>

User not found Alert

<img src="https://github.com/user-attachments/assets/e4fbf98d-789c-4699-af59-2f3b7bfce768" alt="User Not Found Alert" width="400"/>

Offline Warning

<img src="https://github.com/user-attachments/assets/c8cb8b3d-dd05-4d34-b468-1339cfc489db" alt="Offline Warning" width="400"/>

## License

This project is licensed under the MIT License - see the LICENSE file for details.
