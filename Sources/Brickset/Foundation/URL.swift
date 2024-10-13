import Foundation

extension URL {
    public static let documentation: Self = Self(string: "https://brickset.com/article/52664/api-version-3-documentation")!
    public static let requestAPIKey: Self = Self(string: "https://brickset.com/tools/webservices/requestkey")!
    
    static let api: Self = Self(string: "https://brickset.com/api/v3.asmx")!
    
    static func api(_ method: String, query: [URLQueryItem] = []) throws -> Self {
        guard !method.isEmpty else {
            throw URLError(.unsupportedURL)
        }
        return api.appending(path: "\(method)").appending(queryItems: [
            try .apiKey()
        ] + query)
    }
}
