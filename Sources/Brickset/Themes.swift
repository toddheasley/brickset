import Foundation

public struct Themes: Decodable {
    public let theme: String
    public let setCount: Int
    public let subthemeCount: Int
    public let yearFrom: Int
    public let yearTo: Int
}
