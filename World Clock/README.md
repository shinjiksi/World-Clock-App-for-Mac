# World Clock

A macOS/iOS app for displaying current times across multiple cities worldwide.

## Features

- Display current time for multiple cities simultaneously
- Add and remove cities
- Time zone support
- Simple and intuitive UI

## Requirements

- macOS 13.0 or later (for macOS app)
- iOS 16.0 or later (for iOS app)
- Xcode 14.0 or later
- Swift 5.7 or later

## Installation & Running

### 1. Open the Project

```bash
open "World Clock.xcodeproj"
```

### 2. Build & Run

- In Xcode, select "My Mac" or any simulator from the target selector in the top left
- Press **⌘R** (Command + R) to build and run

### 3. Clean Build (if errors occur)

```bash
# In Xcode: Shift + Command + K
# Or
Product → Clean Build Folder
```

## Project Structure

```
World Clock/
├── App/                    # Application core
│   ├── AppDelegate.swift
│   ├── WorldClockApp.swift # Main app entry point
│   └── Info.plist
├── Models/                 # Data models
│   └── City.swift         # City data structure
├── Views/                  # UI screens
│   └── MainView.swift     # Main view
└── Managers/              # Business logic
    └── CityManager.swift  # City management
```

## Development

### Adding New Cities

City list is managed in `CityManager.swift`.

### Customizing the UI

Edit the main UI in `MainView.swift`.

## Distribution

### Distribute as macOS App

1. In Xcode, select **Product → Archive**
2. Choose **Distribute App**
3. Select distribution method:
   - **Direct Distribution**: Distribute as .app file
   - **Developer ID**: Notarized app (recommended)

### Publish to App Store

1. Apple Developer Program membership required
2. **Product → Archive**
3. Upload to **App Store Connect**

## Troubleshooting

### Build Errors

```bash
# Delete Derived Data
rm -rf ~/Library/Developer/Xcode/DerivedData
```

Then in Xcode, **Clean Build Folder** (Shift + Command + K)

### Icon Not Displaying

- Check `WorlClockIcon.icon/icon.json` configuration
- Verify assets are properly included in the target

## License

MIT License

## Author

Shinji Kasai

---

## Future Features

- [ ] Dark mode support
- [ ] Widget support
- [ ] City search functionality
- [ ] Custom time zone settings
