
# BankApp

## Project Name
BankApp - iOS Banking Application

## Description
BankApp is a mobile banking application for iOS that allows users to securely manage their bank accounts, view account details, convert currencies using real-time exchange rates, and locate nearest bank branches with route navigation. The app is built using Swift and UIKit with SQLite database for local data storage, integrated with OpenExchangeRates API for currency conversion and MapKit for branch locations.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-team/BankApp.git
   cd BankApp
   ```
2. Open `BankApp.xcodeproj` in Xcode 14.0+
3. Make sure you have SQLite.swift framework:
   - If using CocoaPods: `pod install` and open `BankApp.xcworkspace`
   - If manual: ensure SQLite.framework is added to project
4. Select your target device or simulator (iOS 13.0+)
5. Build and run the project (Cmd+R)

## Usage
1. **Login**: Use test credentials to access the app
   - Sample credentials are available in the database
   - Error messages will appear for invalid login attempts

2. **Main Menu**: After successful login, you'll see four options:
   - "Мои счета" - View your accounts
   - "Конвертер валют" - Currency converter
   - "Карта отделений" - Bank branches map
   - "Выход" - Logout

3. **View Accounts**: 
   - Tap "Мои счета" to see list of active accounts
   - Each row shows: Account ID, Type, and Balance
   - Tap any account for detailed information

4. **Account Details**:
   - Shows owner name, account type, balance
   - For card accounts: displays subtype
   - For salary cards: shows overdraft limit

5. **Currency Converter**:
   - Select source and target currencies (USD/EUR/RUB)
   - Enter amount to convert
   - Tap "Конвертировать" for real-time conversion

6. **Bank Branches Map**:
   - View 5 bank branches on the map
   - Your location is marked (if permission granted)
   - Tap "Показать маршрут" to get directions to nearest branch

## Features
- Secure user authentication
- Multiple account types support (Current/Savings/Credit/Card)
- Real-time currency conversion
- Interactive map with navigation
- Native iOS UI with UIKit
- Local SQLite database
- Unit and UI tests included
- CI/CD with GitHub Actions

## Technologies Used
- **Language**: Swift 5
- **UI Framework**: UIKit + Storyboard
- **Database**: SQLite (via SQLite.swift)
- **Networking**: URLSession (async/await)
- **Maps**: MapKit + CoreLocation
- **Testing**: XCTest
- **CI/CD**: GitHub Actions
- **Architecture**: MVC

## Project Structure
```
BankApp/
├── Controllers/
│   ├── ViewController.swift         # Login screen
│   ├── ViewControllerMenu.swift     # Main menu
│   ├── ViewControllerAccounts.swift # Accounts list
│   ├── ViewControllerAccount.swift  # Account details
│   ├── ViewControllerConverter.swift # Currency converter
│   └── ViewControllerMap.swift      # Branches map
├── Views/
│   ├── Main.storyboard             # UI layouts
│   ├── accountsCell.xib            # Account cell
│   └── acountDataCell.xib          # Detail cell
├── Supporting Files/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Resources/
│   └── db.sqlite3                  # Database file
└── Tests/
    ├── BankAppTests/               # Unit tests
    └── BankAppUITests/             # UI tests
```

## Contributing
This project was developed by:

- **Ivan Gontarev** - Team Lead, Project Manager, Developer
  - Project architecture and setup
  - Authorization system implementation
  - Database integration
  - Main menu development
  - CI/CD configuration
  - Project management

- **Darya Sidorskaya** - QA Engineer, UI/UX Designer
  - UI/UX design in Figma
  - Interface mockups creation
  - Storyboard development
  - Custom cells design
  - Unit and UI tests
  - Test documentation

- **Victoria Ivanova** - Developer, UI Designer
  - Accounts list implementation
  - Account details screen
  - Currency converter with API integration
  - Map functionality with navigation
  - Code documentation
  - Wiki maintenance

## Requirements
- iOS 13.0+
- Xcode 14.0+
- Swift 5.0+
- Internet connection (for currency converter and map)
- Location services (for map features)

## Links

[Presentation](https://www.canva.com/design/DAGockVJ6sA/2DS3SasGmCrS06E08X4fTA/edit?utm_content=DAGockVJ6sA&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

[Github Pages ](https://fpmi-tp2025.github.io/tpmp-gr9a-lab9-sh/)
