import Foundation

class StarDataManager {
    func getNearbyStars() -> [CelestialObject] {
        return [
            CelestialObject(name: "Proxima Centauri", type: "Star", distanceLY: 4.24),
            CelestialObject(name: "Alpha Centauri A", type: "Star", distanceLY: 4.37),
            CelestialObject(name: "Sirius", type: "Star", distanceLY: 8.6),
            CelestialObject(name: "Vega", type: "Star", distanceLY: 25.0),
            CelestialObject(name: "Betelgeuse", type: "Star", distanceLY: 642.5),
            CelestialObject(name: "Mars", type: "Planet", distanceLY: 0.0000158),
            CelestialObject(name: "Venus", type: "Planet", distanceLY: 0.0000067),
            CelestialObject(name: "Orion", type: "Constellation", distanceLY: 1344.0)
        ]
    }
}
