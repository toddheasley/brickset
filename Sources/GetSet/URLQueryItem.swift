import Foundation

extension URLQueryItem {
    static func params(_ params: Params) throws -> Self {
        let value: String = try JSONEncoder.sortedKeys.params(params)
        return Self(name: "params", value: value)
    }
    
    static func set(number value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "setNumber", value: value)
    }
    
    static func set(id value: Int) throws -> Self {
        guard value >= 0 else {
            throw Error.parameterError
        }
        return Self(name: "setID", value: "\(value)")
    }
    
    static func apiKey() throws -> Self {
        guard let value: String = URLCredentialStorage.shared.apiKey else {
            throw Error.invalidAPIKey
        }
        return Self(name: "apiKey", value: value)
    }
}
