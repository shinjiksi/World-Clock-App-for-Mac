# World Clock Menu Bar App

A macOS menu bar application that displays time for cities around the world.

## Features

- ✅ Display up to 5 cities in menu bar (e.g., 🇺🇸 Boi 14:32)
- ✅ Search cities by name
- ✅ Cities organized by region (Japan, US, Canada, Philippines, Mexico, World)
- ✅ Checkbox selection system
- ✅ Auto-save selected cities (persistent across app restarts)
- ✅ Real-time clock updates
- ✅ Selected cities appear at the top of the list
- ✅ Toggle menu bar icon (🌍) visibility
- ✅ Clean, native macOS interface

## Screenshots

Menu bar display example:
```
🌍  🇯🇵 Tok 15:30  🇺🇸 NY 01:30  🇬🇧 Lon 06:30
```

## Setup Instructions

### 1. Create New Xcode Project

1. Open Xcode
2. **File → New → Project**
3. Choose **macOS** → **App**
4. Product Name: `World Clock`
5. Interface: **SwiftUI**
6. Language: **Swift**
7. Click **Next** and save

### 2. Project Structure

Create this folder structure in your project:

```
World Clock/
├── App/
│   ├── WorldClockApp.swift
│   ├── AppDelegate.swift
│   └── Info.plist
├── Managers/
│   └── CityManager.swift
├── Models/
│   └── City.swift
└── Views/
    └── MainView.swift
```

### 3. Add Files

Copy and paste each provided file:

1. **WorldClockApp.swift** → App folder
2. **AppDelegate.swift** → App folder
3. **City.swift** → Models folder
4. **CityManager.swift** → Managers folder
5. **MainView.swift** → Views folder
6. **Info.plist** → Replace existing Info.plist

### 4. Configure Info.plist

The provided Info.plist includes:
- `LSUIElement = true` (hides app from Dock, shows only in menu bar)

### 5. Fix Build Errors (if they occur)

**If you get a Bridging Header error:**

1. Click on the project name
2. Select the target
3. Go to **Build Settings** tab
4. Search for "bridging"
5. Find **Objective-C Bridging Header**
6. Delete the file path value
7. Press Enter to confirm

### 6. Add App Icon (Optional)

To add a custom icon:

1. In Xcode, open **Assets.xcassets**
2. Click **AppIcon**
3. Drag your icon images into the appropriate size slots
4. Recommended sizes: 16x16, 32x32, 128x128, 256x256, 512x512, 1024x1024

**Icon Ideas:**
- Globe with clock overlay
- Multiple time zones visualization
- World map with clock hands

Icon creation tools:
- SF Symbols (macOS built-in)
- Figma or Sketch
- Online icon generators

### 7. Build and Run

1. Select your Mac as the target device
2. Press **Cmd + R** to build and run
3. The app will appear in your menu bar (top right)
4. Click the globe icon to open the city selection window

## Usage

### Basic Operations

1. **Search Cities**: Type in the search box to filter cities
2. **Select Cities**: Click checkbox next to city name (max 5)
3. **View Menu Bar**: Selected cities appear with flag, short name, and time
4. **Quit**: Click the "Quit" button to close the app

### Settings

**Toggle Menu Bar Icon Visibility:**
- Settings section at the top of the window
- "Show globe icon in menu bar" checkbox
- ☑️ Checked: Shows 🌍 icon
- ☐ Unchecked: Hides icon (shows only time)

### Selected Cities

Selected cities are displayed as follows:
- Appear at the top in a "Selected Cities" section
- Highlighted with blue background
- Uncheck to move back to regional section

## Included Cities

- **Japan**: Tokyo, Osaka, Sapporo, Fukuoka
- **United States**: 25+ major cities including New York, Los Angeles, San Francisco, Boise, etc.
- **Canada**: Toronto, Vancouver, Montreal, Calgary, Ottawa, Edmonton
- **Philippines**: Manila, Cebu, Davao, Quezon City
- **Mexico**: Mexico City, Guadalajara, Monterrey, Cancún
- **Major World Cities**: London, Paris, Berlin, Dubai, Singapore, Hong Kong, Sydney, Mumbai, São Paulo

## Customization

### Add More Cities

Edit `CityManager.swift` and add to the `loadCities()` function:

```swift
City(name: "City Name", shortName: "Short", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan")
```

### Change Maximum Cities

In `CityManager.swift`, modify the number in `toggleCity()`:

```swift
if !cities[index].isSelected && selectedCount >= 5 {  // Change 5 to your limit
```

### Update Menu Bar Format

In `AppDelegate.swift`, modify `updateMenuBarTitle()` to change the display format.

### Change Icon

In `AppDelegate.swift`, change the icon:

```swift
button.image = NSImage(systemSymbolName: "globe.asia.australia", accessibilityDescription: "World Clock")
```

Available icons:
- `"globe"` - Globe
- `"globe.americas"` - Americas globe
- `"globe.asia.australia"` - Asia/Australia globe
- `"clock"` - Clock
- `"clock.fill"` - Filled clock

## Troubleshooting

**App doesn't appear in menu bar:**
- Check Info.plist has `LSUIElement = true`
- Restart the app

**Cities not saving:**
- Check UserDefaults permissions
- Reset: `UserDefaults.standard.removeObject(forKey: "selectedCities")`

**Wrong time displayed:**
- Verify timezone identifier is correct
- Check system time settings

**Build errors:**
- Remove Bridging Header reference (Build Settings)
- Clean Build Folder (Shift+Cmd+K) then rebuild

## Technical Specifications

- **Supported OS**: macOS 12.0 or later
- **Development**: Xcode 14.0 or later
- **Language**: Swift 5.7 or later
- **Frameworks**: SwiftUI, AppKit, Combine

## File Structure

| File | Description |
|------|-------------|
| `WorldClockApp.swift` | App entry point |
| `AppDelegate.swift` | Menu bar management and lifecycle |
| `City.swift` | City data model |
| `CityManager.swift` | City list and selection management |
| `MainView.swift` | Main window UI |
| `Info.plist` | App configuration |

## Feature Details

### Menu Bar Display
- Update frequency: Every minute
- Format: `[flag] [short name] [time]`
- Maximum 5 cities simultaneously

### Time Updates
- Menu bar: Every minute
- Window clocks: Every second

### Data Persistence
- Selected cities: Saved to UserDefaults
- Icon visibility setting: Saved to UserDefaults

## License

Free to use for personal or commercial projects. Modify as needed.

## Future Feature Ideas

- [ ] Time zone difference display
- [ ] 12/24 hour format toggle
- [ ] Custom city addition
- [ ] Enhanced dark mode support
- [ ] Keyboard shortcut to show window
- [ ] Drag & drop to reorder cities

## Support

If you encounter issues or have questions, please use the GitHub Issues section.

---

**Developer Tips:**
- Code is structured for readability
- Each file follows single responsibility principle
- Uses SwiftUI and Combine for reactive UI
- Simple data persistence with UserDefaults

Enjoy the app! 🌍⏰
