import Foundation

extension URLQueryItem {
    static func params(_ params: Params, allowEmpty: Bool = false) throws -> Self {
        let value: String = params.value
        guard allowEmpty || value.count > 6  else {
            throw Error.noValidParameters
        }
        return Self(name: "params", value: value)
    }
    
    static func theme(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "theme", value: value)
    }
    
    static func minifig(number value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "minifigNumber", value: value)
    }
    
    static func set(number value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.parameterError
        }
        return Self(name: "setNumber", value: value)
    }
    
    static func set(id value: Int) -> Self {
        Self(name: "setID", value: "\(value)")
    }
    
    static func username(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        return Self(name: "username", value: value)
    }
    
    static func password(_ value: String) throws -> Self {
        guard !value.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        return Self(name: "password", value: value)
    }
    
    static func userHash() throws -> Self {
        guard let value: String = URLCredentialStorage.shared.userHash?.hash else {
            throw Error.invalidUserHash
        }
        return Self(name: "userHash", value: value)
    }
    
    static func apiKey() throws -> Self {
        guard let value: String = URLCredentialStorage.shared.apiKey else {
            throw Error.invalidAPIKey
        }
        return Self(name: "apiKey", value: value)
    }
}
