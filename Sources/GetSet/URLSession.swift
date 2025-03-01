import Foundation

extension URLSession {
    public func checkKey() async throws {
        let data: Data = try await data(for: try .checkKey()).0
        try JSONDecoder().check(data)
    }
    
    public func getKeyUsageStats() async throws -> ([APIKeyUsage], Int?) {
        let data: Data = try await data(for: try .getKeyUsageStats()).0
        return try JSONDecoder(.format).decode([APIKeyUsage].self, from: data, key: "apiKeyUsage")
    }
    
    public func getSets(_ params: Params) async throws -> ([Sets], Int?) {
        let data: Data = try await data(for: try .getSets(params)).0
        return try JSONDecoder(.format).decode([Sets].self, from: data, key: "sets")
    }
    
    public func getAdditionalImages(set id: Int) async throws -> ([Sets.Image], Int?) {
        let data: Data = try await data(for: try .getAdditionalImages(set: id)).0
        return try JSONDecoder().decode([Sets.Image].self, from: data, key: "additionalImages")
    }
    
    public func getInstructions(set id: Int) async throws -> ([Instructions], Int?) {
        let data: Data = try await data(for: try .getInstructions(set: id)).0
        return try JSONDecoder().decode([Instructions].self, from: data, key: "instructions")
    }
    
    public func getInstructions(set number: String) async throws -> ([Instructions], Int?) {
        let data: Data = try await data(for: try .getInstructions(set: number)).0
        return try JSONDecoder().decode([Instructions].self, from: data, key: "instructions")
    }
}
