import Foundation

class OllamaService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private struct Reply: Codable {
        var model: String
        var response: String
        var done: Bool
    }
    
    func translate(model: String, prompt: String) async throws -> String {
        guard let endpoint = URL(string: "http://localhost:11434/api/generate") else {
            throw NSError()
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonDictionary: [String: Any] = ["model": model, "prompt": prompt, "stream": false]
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server response"])
        }
            
        let decoder = JSONDecoder()
        let reply = try decoder.decode(Reply.self, from: data)
        return reply.response
    }
}
