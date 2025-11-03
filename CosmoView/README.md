# CosmoView

#### Video Demo: <https://youtu.be/r5RYdrH-mKc>

## Overview
CosmoView is an iOS app that lets users explore nearby stars and view NASA’s Astronomy Picture of the Day (APOD) — and it works even when the device is offline. The app focuses on a clean SwiftUI interface, a small built-in star catalog for reliable offline use, and an optional online APOD fetch when internet access is available. CosmoView was built as a CS50 final project and demonstrates the use of Swift 6, SwiftUI, `@MainActor`-isolated view models, and async/await network calls with safe offline fallbacks.

## What the app does
- Displays a searchable, sortable list of nearby stars (name + distance in light years).
- Uses a locally embedded catalog of real nearby stars so the app is fully functional without internet.
- Fetches NASA’s APOD when online and displays title, image, and explanation; if APOD is unavailable the app presents a friendly fallback message.
- Clean, responsive UI implemented in SwiftUI using `@StateObject` and `@MainActor` view models to avoid threading issues with UI updates.

### Key files explained
- **CelestialObject.swift** — simple `Identifiable` model used by SwiftUI `ForEach`. Distances are stored in light years (LY) to match common user expectations.
- **StarDataManager.swift** — contains a hardcoded list of nearby stars (50–100 real entries in the shipped version). The `loadStars()` method returns this list immediately and the manager is intentionally offline-first so the app never depends on unstable external endpoints.
- **NASAService.swift** — a small async/await wrapper around `URLSession` that fetches APOD JSON from the NASA API. The service is optional; if no API key is provided or the network call fails, APODViewModel falls back to an offline message.
- **SkyViewModel.swift** & **APODViewModel.swift** — `@MainActor` `ObservableObject` view models that publish changes to the UI safely. They use async tasks to load data and set `@Published` properties on the main actor to avoid SwiftUI concurrency warnings.
- **ContentView.swift** — main stars UI. Features a searchable list, toggleable distance sort, and an offline banner that appears only when necessary. Uses `.task` to request star data via the view model.
- **APODView.swift** — presents APOD content with `AsyncImage` for smooth image loading. Shows a fallback message and placeholder UI when offline or when APOD is unavailable.

## Design choices and rationale
- **Offline-first approach:** several public star catalogs are either very large or unreliable as single raw URLs. For a CS50 final project we need reliability and reproducibility. Shipping a curated local catalog ensures the app always works during demos and grading without network variability.
- **SwiftUI + @MainActor:** Swift 6 enforces main-actor isolation for UI-updating types. I used `@MainActor` on view models and async/await patterns to keep code modern and minimize threading/bindings bugs (the common “publishing from background threads” issue).
- **Async/await for network calls:** APOD fetching uses async/await for clarity and correctness. The app decodes JSON using `JSONDecoder` and performs decoding on the main actor when needed to respect any main-actor-isolated models.
- **Small, focused feature set:** The app demonstrates clear functionality (stars + APOD) with polished UI rather than a broad, half-finished feature set. This keeps the project within scope and suitable for a graded final.

## How to run
1. Open the project in Xcode (macOS; Xcode 15+ recommended for Swift 6 compatibility).
2. Select an iOS simulator or your device (you can run on-device with a free Apple ID but provisioning expires weekly).
3. Build and run. The star list appears immediately from the embedded catalog. Tap the APOD tab to fetch the daily image if online.
4. To test offline behavior, disable network access (or block the APOD fetch) — the app will continue to show stars and present a fallback APOD message.

## Notes about submission / CS50
- You do not need an Apple Developer Program account to run the app locally or to produce the demo video. You only need the paid account if you want to distribute via the App Store or TestFlight.
- During Testing, NASA APOD was offline.

## Future improvements
- Add more stars from a hosted JSON catalog and implement incremental download/caching to combine an online data source with offline fallback.
- Add constellation grouping, visualization map (sky coordinates), and deep links to external resources.
- Add user preferences (distance threshold, units: LY/parsec) and Core Data / SwiftData optional persistence if the catalog is updated frequently.

## License & Acknowledgements
- CosmoView is open for personal/educational use. If you reuse code or data from third parties (e.g., NASA APOD, star catalogs), follow their terms (NASA APOD requires attribution; star catalog sources should be credited).
- APOD: data provided by NASA API. Replace `YOUR_API_KEY` in `NASAService.swift` with your own key for live APOD access.
