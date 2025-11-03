import Foundation

class SkyViewModel: ObservableObject {
    private let starManager = StarDataManager()
    @Published var stars: [CelestialObject] = []

    func loadStars() {
        stars = starManager.getNearbyStars()
    }

    func getObjects(ofType type: String) -> [CelestialObject] {
        return stars.filter { $0.type.lowercased() == type.lowercased() }
    }
}
