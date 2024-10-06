import Foundation

extension URLQueryItem {
    public static func params(_ params: Params, allowEmpty: Bool = false) throws -> Self {
        let value: String = params.value
        guard allowEmpty || value.count > 6  else {
            throw Error.noValidParameters
        }
        return Self(name: "params", value: value)
    }
    
    public static func theme(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "theme", value: value)
    }
    
    public static func minifig(number value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "minifigNumber", value: value)
    }
    
    public static func set(number value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "setNumber", value: value)
    }
    
    public static func set(id value: Int) -> Self {
        Self(name: "setID", value: "\(value)")
    }
    
    public static func username(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        return Self(name: "username", value: value)
    }
    
    public static func password(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        return Self(name: "password", value: value)
    }
    
    public static func userHash() throws -> Self {
        guard let value: String = URLCredentialStorage.shared.userHash?.hash else {
            throw Error.invalidUserHash
        }
        return Self(name: "userHash", value: value)
    }
    
    public static func apiKey() throws -> Self {
        guard let value: String = URLRequest.apiKey else {
            throw Error.invalidAPIKey
        }
        return Self(name: "apiKey", value: value)
    }
}
