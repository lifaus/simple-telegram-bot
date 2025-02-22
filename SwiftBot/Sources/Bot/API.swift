import Foundation

let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"]!

struct APIResponse<T: Decodable>: Decodable {
    let ok: Bool
    let result: T
}

func apiRequest<T: Decodable>(methodName: String, params: [String: String]) async throws -> T {
    var components = URLComponents(string: "https://api.telegram.org/bot\(accessToken)/\(methodName)")!
    components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }

    guard let url = components.url else { throw URLError(.badURL) }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    return try JSONDecoder().decode(T.self, from: data)
}

func getUpdates(offset: Int) async throws -> [Update] {
    let response: APIResponse<[Update]> = try await apiRequest(methodName: "getUpdates", params: ["offset": "\(offset)"])
    return response.result
}

func sendMessage(message: String, userId: Int) async throws {
    let _ : APIResponse<Message> = try await apiRequest(
        methodName: "sendMessage",
        params: [
            "chat_id": "\(userId)",
            "text": message
        ]
    )

}
