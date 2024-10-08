import Foundation

extension URLRequest {
    public static func checkKey() throws -> Self {
        try Self("checkKey")
    }
    
    public static func login(_ username: String, password: String) throws -> Self {
        try Self("login", query: [
            try .username(username),
            try .password(password)
        ])
    }
    
    public static func checkUserHash() throws -> Self {
        try Self("checkUserHash", query: [
            try .userHash()
        ])
    }
    
    public static func getKeyUsageStats() throws -> Self {
        try Self("getKeyUsageStats")
    }
    
    public static func getSets(_ params: GetSets) throws -> Self {
        try Self("getSets", query: [
            try .userHash(),
            try .params(params)
        ])
    }
    
    public static func getAdditionalImages(set id: Int) throws -> Self {
        try Self("getAdditionalImages", query: [
            .set(id: id)
        ])
    }
    
    public static func getInstructions(set id: Int) throws -> Self {
        try Self("getInstructions", query: [
            .set(id: id)
        ])
    }
    
    public static func getInstructions(set number: String) throws -> Self {
        try Self("getInstructions2", query: [
            try .set(number: number)
        ])
    }
    
    public static func getReviews(set id: Int) throws -> Self {
        try Self("getReviews", query: [
            .set(id: id)
        ])
    }
    
    public static func getThemes() throws -> Self {
        try Self("getThemes")
    }
    
    public static func getSubthemes(_ theme: String) throws -> Self {
        try Self("getSubthemes", query: [
            try .theme(theme)
        ])
    }
    
    public static func getYears(_ theme: String? = nil) throws -> Self {
        try Self("getYears", query: theme != nil ? [
            try .theme(theme!)
        ] : [])
    }
    
    public static func setCollection(_ params: SetCollection, set id: Int) throws -> Self {
        try Self("setCollection", query: [
            try .userHash(),
            try .params(params),
            .set(id: id)
        ])
    }
    
    public static func getUserNotes() throws -> Self {
        try Self("getUserNotes", query: [
            try .userHash()
        ])
    }
    
    public static func getMinifigCollection(_ params: GetMinifigCollection) throws -> Self {
        try Self("getMinifigCollection", query: [
            try .userHash(),
            try .params(params)
        ])
    }
    
    public static func setMinifigCollection(_ params: SetMinifigCollection, minifig number: String) throws -> Self {
        try Self("setMinifigCollection", query: [
            try .userHash(),
            try .params(params, allowEmpty: true),
            try .minifig(number: number)
        ])
    }
    
    public static func getUserMinifigNotes() throws -> Self {
        try Self("getUserMinifigNotes", query: [
            try .userHash()
        ])
    }
    
    private init(_ method: String, query: [URLQueryItem] = [], httpMethod: String = "GET") throws {
        self.init(url: try .api(method, query: query))
        self.httpMethod = httpMethod
    }
}

extension URL {
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
