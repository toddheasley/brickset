import Foundation

extension URLRequest {
    static func checkKey() throws -> Self {
        try Self("checkKey")
    }
    
    static func getKeyUsageStats() throws -> Self {
        try Self("getKeyUsageStats")
    }
    
    static func getSets(_ params: Params) throws -> Self {
        try Self("getSets", query: [
            URLQueryItem(name: "userHash", value: ""), // Empty user hash parameter required
            try .params(params)
        ])
    }
    
    static func getAdditionalImages(set id: Int) throws -> Self {
        try Self("getAdditionalImages", query: [
            .set(id: id)
        ])
    }
    
    static func getInstructions(set id: Int) throws -> Self {
        try Self("getInstructions", query: [
            .set(id: id)
        ])
    }
    
    static func getInstructions(set number: String) throws -> Self {
        try Self("getInstructions2", query: [
            try .set(number: number)
        ])
    }
    
    private init(_ method: String, query: [URLQueryItem] = [], httpMethod: String = "GET") throws {
        self.init(url: try .api(method, query: query))
        self.httpMethod = httpMethod
    }
}
