import Foundation

public struct Reviews: Decodable {
    public struct Rating: Decodable {
        public let overall: Int? // 1-5
        public let parts: Int? // 1-5
        public let buildingExperience: Int? // 1-5
        public let playability: Int? // 1-5
        public let valueForMoney: Int? // 1-5
    }
    
    public let author: String
    public let datePosted: Date
    public let rating: Rating
    public let title: String
    public let review: String
    public let HTML: Bool
}
