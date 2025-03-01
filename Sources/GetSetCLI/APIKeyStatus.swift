import Foundation
import GetSet

enum APIKeyStatus: Int, CaseIterable, CustomStringConvertible {
    case valid = 32 // Green
    case invalid = 31 // Red
    case unknown = 0
    
    static var current: Self {
        get async {
            do {
                try await URLSession.shared.checkKey()
                return .valid
            } catch Error.invalidAPIKey {
                return .invalid
            } catch {
                return .unknown
            }
        }
    }
    
    // MARK: CustomStringConvertible
    var description: String { "\u{001B}[0;\(rawValue)m" }
}

extension String {
    func colorCoded(for status: APIKeyStatus = .unknown) -> Self {
        "\(status)\(self)\(APIKeyStatus.unknown)"
    }
}
