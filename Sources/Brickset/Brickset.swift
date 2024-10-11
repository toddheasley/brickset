import Foundation

@Observable public class Brickset {
    public let documentation: URL = .documentation
    public var error: Error?
    
    public var key: String? {
        set {
            do {
                try URLCredentialStorage.shared.setAPIKey(newValue)
            } catch {
                self.error = error as? Error
            }
        }
        get { URLCredentialStorage.shared.apiKey }
    }
    
    public init() {
        
    }
}
