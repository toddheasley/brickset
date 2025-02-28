import Foundation

public struct Instructions: Decodable, CustomStringConvertible {
    public let URL: URL
    
    public init(_ description: String, url: URL) {
        self.description = description
        self.URL = url
    }
    
    // MARK: CustomStringConvertible
    public let description: String
}
