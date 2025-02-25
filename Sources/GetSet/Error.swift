import Foundation

public enum Error: String, Swift.Error, Codable, CaseIterable, CustomStringConvertible {
    case noValidParameters = "No valid parameters"
    case parameterError = "Parameter error"
    case apiLimitExceeded = "API limit exceeded"
    case invalidAPIKey = "Invalid API key"
    
    // MARK: CustomStringConvertible
    public var description: String { rawValue }
}
