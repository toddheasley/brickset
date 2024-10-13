import Foundation

extension URLSession {
    public func checkKey() async throws {
        let data: Data = try await data(for: try .checkKey()).0
        try JSONDecoder().check(data)
    }
    
    public func login(_ username: String, password: String) async throws {
        let data: Data = try await data(for: try .login(username, password: password)).0
        guard let jsonObject: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw URLError(.cannotDecodeContentData)
        }
        try JSONDecoder().check(jsonObject)
        guard let hash: String = jsonObject["hash"] as? String else {
            throw URLError(.cannotDecodeContentData)
        }
        try URLCredentialStorage.shared.setUserHash(hash, username: username)
    }
    
    public func checkUserHash() async throws {
        let data: Data = try await data(for: try .checkUserHash()).0
        try JSONDecoder().check(data)
    }
    
    public func getKeyUsageStats() async throws -> ([APIKeyUsage], Int?) {
        let data: Data = try await data(for: try .getKeyUsageStats()).0
        return try JSONDecoder(.format).decode([APIKeyUsage].self, from: data, key: "apiKeyUsage")
    }
    
    public func getSets(_ params: GetSets) async throws -> ([Sets], Int?) {
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
    
    public func getReviews(set id: Int) async throws -> ([Reviews], Int?) {
        let data: Data = try await data(for: try .getReviews(set: id)).0
        return try JSONDecoder(.format).decode([Reviews].self, from: data, key: "reviews")
    }
    
    public func getThemes() async throws -> ([Themes], Int?) {
        let data: Data = try await data(for: try .getThemes()).0
        return try JSONDecoder().decode([Themes].self, from: data, key: "themes")
    }
    
    public func getSubthemes(_ theme: String) async throws -> ([Subthemes], Int?) {
        let data: Data = try await data(for: try .getSubthemes(theme)).0
        return try JSONDecoder().decode([Subthemes].self, from: data, key: "subthemes")
    }
    
    public func getYears(_ theme: String? = nil) async throws -> ([Years], Int?) {
        let data: Data = try await data(for: try .getYears(theme)).0
        return try JSONDecoder().decode([Years].self, from: data, key: "years")
    }
    
    public func setCollection(_ params: SetCollection, set id: Int) async throws {
        let data: Data = try await data(for: try .setCollection(params, set: id)).0
        try JSONDecoder().check(data)
    }
    
    public func getUserNotes() async throws -> ([UserNotes], Int?) {
        let data: Data = try await data(for: try .getUserNotes()).0
        return try JSONDecoder().decode([UserNotes].self, from: data, key: "userNotes")
    }
    
    public func getMinifigCollection(_ params: GetMinifigCollection) async throws -> ([MinifigCollection], Int?) {
        let data: Data = try await data(for: try .getMinifigCollection(params)).0
        return try JSONDecoder().decode([MinifigCollection].self, from: data, key: "minifigs")
    }
    
    public func setMinifigCollection(_ params: SetMinifigCollection, set number: String) async throws {
        let data: Data = try await data(for: try .setMinifigCollection(params, minifig: "col445")).0
        try JSONDecoder().check(data)
    }
    
    public func getUserMinifigNotes() async throws -> ([UserMinifigNotes], Int?) {
        let data: Data = try await data(for: try .getUserMinifigNotes()).0
        return try JSONDecoder().decode([UserMinifigNotes].self, from: data, key: "userMinifigNotes")
    }
}
