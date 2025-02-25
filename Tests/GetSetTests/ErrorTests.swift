import Foundation
@testable import GetSet
import Testing

struct ErrorTests {
    
    // MARK: Codable
    @Test func decoderInit() throws {
        #expect(try JSONDecoder().decode([Error].self, from: data) == Error.allCases)
    }
    
    @Test func encode() throws {
        let data: Data = try JSONEncoder().encode(Error.allCases)
        #expect(try JSONDecoder().decode([Error].self, from: data) == Error.allCases)
    }
    
    // MARK: CaseIterable
    @Test func allCases() {
        #expect(Error.allCases == [
            .noValidParameters,
            .parameterError,
            .apiLimitExceeded,
            .invalidAPIKey
        ])
    }
    
    // MARK: CustomStringConvertible
    @Test("", arguments: Error.allCases) func description(_ error: Error) {
        #expect(error.description == error.rawValue)
    }
}

private let data: Data = """
[
    "No valid parameters",
    "Parameter error",
    "API limit exceeded",
    "Invalid API key"
]
""".data(using: .utf8)!
