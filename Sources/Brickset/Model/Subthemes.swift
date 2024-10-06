import Foundation

public struct Subthemes: Decodable {
    public let theme: String
    public let subtheme: String
    public let setCount: Int
    public let yearFrom: Int
    public let yearTo: Int
}
