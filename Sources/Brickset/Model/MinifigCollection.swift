import Foundation

public struct MinifigCollection: Decodable {
    public let minifigNumber: String
    public let name: String
    public let category: String
    public let ownedInSets: Int
    public let ownedLoose: Int
    public let ownedTotal: Int
    public let wanted: Bool
}
