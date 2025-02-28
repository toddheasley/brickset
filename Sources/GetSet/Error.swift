import Foundation

public enum Error: String, Swift.Error, Codable, CaseIterable, CustomStringConvertible {
    case noValidParameters = "no valid parameters"
    case parameterError = "parameter error"
    case apiLimitExceeded = "API limit exceeded"
    case invalidAPIKey = "invalid API key"
    
    // MARK: CustomStringConvertible
    public var description: String { rawValue }
}
