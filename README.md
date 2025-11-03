# CosmoView

#### Video Demo: <https://youtu.be/r5RYdrH-mKc>

## Overview
CosmoView is an iOS app designed to give users an interactive and educational experience exploring nearby stars and NASA’s Astronomy Picture of the Day (APOD). The app emphasizes both functionality and reliability, ensuring that even when offline, users can explore a curated catalog of nearby stars. The project was built using Swift 6 and SwiftUI for a modern, responsive interface, and it leverages `@MainActor`-isolated view models to safely update the UI asynchronously. CosmoView was developed as a final project for CS50 and demonstrates proficiency in Swift, SwiftUI, asynchronous programming, and offline-first application design.

## What the app does
- Displays a list of nearby stars with their names, types, and distances in light years. The list is searchable and sortable, allowing users to easily explore stars based on proximity.
- Provides NASA’s Astronomy Picture of the Day, fetched from the NASA API when online. When the network is unavailable, the app gracefully presents a fallback message so that users know APOD is temporarily unavailable.
- The star data is stored locally within the app, allowing the star list feature to function completely offline. This ensures that the app remains fully functional even without internet connectivity.
- Uses a clean and intuitive SwiftUI interface, with observable view models managing the presentation of both stars and APOD content.

## Files and their roles
- **CosmoViewApp.swift**: This is the main entry point for the app. It initializes the SwiftUI App lifecycle and sets up the main navigation or tab structure for switching between the stars list and the APOD view.
- **Models**:  
  - `CelestialObject.swift` defines the structure of a star or celestial object, including its name, type, distance from Earth in light years, and a unique identifier.  
  - `APOD.swift` defines the structure of NASA’s Astronomy Picture of the Day response, including the title, image URL, date, and explanation.
- **Services**:  
  - `StarDataManager.swift` provides the hardcoded offline catalog of nearby stars. This list includes 50–100 real stars with accurate distances and allows the app to function without any online dependency.  
  - `NASAService.swift` handles the asynchronous fetching of APOD data using `URLSession`. If the device is offline or the API call fails, the service returns `nil` and the app shows a fallback message.
- **ViewModels**:  
  - `SkyViewModel.swift` manages the star data for the SwiftUI views. It uses `@Published` properties and `@MainActor` isolation to safely update the user interface without threading issues.  
  - `APODViewModel.swift` manages the APOD data, handling async fetch calls and updating the view with the latest picture or an offline fallback message.
- **Views**:  
  - `ContentView.swift` displays the star list. It shows nearby stars in order of distance, allows searching, and displays an offline indicator when network access is unavailable.  
  - `APODView.swift` displays the Astronomy Picture of the Day. It uses `AsyncImage` to load images smoothly and includes a fallback text and placeholder image when the API is unreachable.

## Design choices and rationale
- **Offline-first approach**: Shipping a local catalog of stars ensures that the app functions reliably for grading and user testing without depending on external APIs or internet access. It also allows users to explore stars even in remote areas without connectivity.  
- **SwiftUI + @MainActor**: To adhere to Swift 6 concurrency rules, view models are marked with `@MainActor`, and all UI updates are performed on the main actor. This prevents common runtime warnings about publishing changes from background threads and ensures smooth updates in SwiftUI.  
- **Asynchronous APOD fetch**: While the star list is offline, the APOD feature demonstrates handling of asynchronous network calls. The app uses modern async/await patterns with completion handlers that respect main actor isolation.  
- **Focused scope**: The app’s core features (nearby stars + APOD) are fully implemented, polished, and reliable. This focus avoids half-finished features and keeps the project within scope for a CS50 final submission.

## How to run the app
1. Open the project in Xcode (Xcode 15+ recommended).  
2. Select an iOS simulator or a connected device. Running on-device with a free Apple ID works, but provisioning will expire weekly.  
3. Build and run the project. The star list appears immediately from the embedded catalog. Users can browse, search, and sort stars.  
4. Tap the APOD view to fetch NASA’s Astronomy Picture of the Day. If offline or the API is unavailable, a fallback message appears.  

## Notes about submission
- The project includes a `README.md` and a demonstration video. For CS50, submit both via `submit50`.  
- No Apple Developer Program account is required to run or demo the app. The project can be tested fully locally.  
- The hardcoded star catalog ensures reliable functionality during grading.  

## Future improvements
- Incorporate a hosted star catalog to allow dynamic updates while maintaining offline fallback.  
- Add constellation grouping or a 3D star map visualization.  
- Implement user preferences (distance threshold, units like LY or parsec) and optional persistent storage via SwiftData or Core Data.  
- Add notifications for APOD updates or featured stars of the week.  

## License & acknowledgements
- CosmoView is intended for educational and personal use. Any third-party data (NASA APOD, star catalogs) must be credited according to their respective licenses.  
- APOD data comes from NASA API and requires an API key for live fetching. Replace `YOUR_API_KEY` in `NASAService.swift` with your own key.  
