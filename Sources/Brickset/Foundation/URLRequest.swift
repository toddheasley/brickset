import Foundation

extension URLRequest {
    static func checkKey() throws -> Self {
        try Self("checkKey")
    }
    
    static func login(_ username: String, password: String) throws -> Self {
        try Self("login", query: [
            try .username(username),
            try .password(password)
        ])
    }
    
    static func checkUserHash() throws -> Self {
        try Self("checkUserHash", query: [
            try .userHash()
        ])
    }
    
    static func getKeyUsageStats() throws -> Self {
        try Self("getKeyUsageStats")
    }
    
    static func getSets(_ params: GetSets) throws -> Self {
        try Self("getSets", query: [
            try .userHash(isRequired: false), // Value is optional (but empty query parameter required?)
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
    
    static func getReviews(set id: Int) throws -> Self {
        try Self("getReviews", query: [
            .set(id: id)
        ])
    }
    
    static func getThemes() throws -> Self {
        try Self("getThemes")
    }
    
    static func getSubthemes(_ theme: String) throws -> Self {
        try Self("getSubthemes", query: [
            try .theme(theme)
        ])
    }
    
    static func getYears(_ theme: String? = nil) throws -> Self {
        try Self("getYears", query: theme != nil ? [
            try .theme(theme!)
        ] : [])
    }
    
    static func setCollection(_ params: SetCollection, set id: Int) throws -> Self {
        try Self("setCollection", query: [
            try .userHash(),
            try .params(params),
            .set(id: id)
        ])
    }
    
    static func getUserNotes() throws -> Self {
        try Self("getUserNotes", query: [
            try .userHash()
        ])
    }
    
    static func getMinifigCollection(_ params: GetMinifigCollection) throws -> Self {
        try Self("getMinifigCollection", query: [
            try .userHash(),
            try .params(params)
        ])
    }
    
    static func setMinifigCollection(_ params: SetMinifigCollection, minifig number: String) throws -> Self {
        try Self("setMinifigCollection", query: [
            try .userHash(),
            try .params(params, allowEmpty: true),
            try .minifig(number: number)
        ])
    }
    
    static func getUserMinifigNotes() throws -> Self {
        try Self("getUserMinifigNotes", query: [
            try .userHash()
        ])
    }
    
    private init(_ method: String, query: [URLQueryItem] = [], httpMethod: String = "GET") throws {
        self.init(url: try .api(method, query: query))
        self.httpMethod = httpMethod
    }
}
