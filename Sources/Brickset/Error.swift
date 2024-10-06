import Foundation

public enum Error: String, Swift.Error, Codable, CaseIterable, CustomStringConvertible {
    case noValidParameters = "No valid parameters"
    case parameterError = "Parameter error"
    case invalidUsernameOrPassword = "Invalid username or password"
    case invalidUserHash = "Invalid user hash"
    case apiLimitExceeded = "API limit exceeded"
    case invalidAPIKey = "Invalid API key"
    
    // MARK: CustomStringConvertible
    public var description: String { rawValue }
}
