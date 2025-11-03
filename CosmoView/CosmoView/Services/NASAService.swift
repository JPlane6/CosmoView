import Foundation

class NASAService {
    private let apiKey = "vLmufE8tLWb3NIAivc3jaro3CmK3BcJPyMcB4ADL" // Replace with your NASA API key

    func fetchAPOD(completion: @escaping (APOD?) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let apod = try? JSONDecoder().decode(APOD.self, from: data)
            completion(apod)
        }.resume()
    }
}
