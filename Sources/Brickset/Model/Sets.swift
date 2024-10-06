import Foundation

public struct Sets: Decodable {
    public struct Image: Decodable {
        public let thumbnailURL: URL?
        public let imageURL: URL?
    }
    
    public struct Collection: Decodable {
        public let owned: Bool
        public let wanted: Bool
        public let qtyOwned: Int?
        public let rating: Int?
        public let notes: String
    }
    
    public struct Collections: Decodable {
        public let ownedBy: Int?
        public let wantedBy: Int?
    }
    
    public struct LEGOCom: Decodable {
        public struct Details: Decodable {
            public let retailPrice: Decimal?
            public let dateFirstAvailable: Date?
            public let dateLastAvailable:Date?
        }
        
        public let US: Details
        public let UK: Details
        public let CA: Details
        public let DE: Details
    }
    
    public struct AgeRange: Decodable {
        public let min: Int?
        public let max: Int?
    }
    
    public struct Dimensions: Decodable {
        public let height: Double?
        public let width: Double?
        public let depth: Double?
        public let weight: Double?
    }
    
    public struct Barcodes: Decodable {
        public let EAN: String?
        public let UPC: String?
    }
    
    public struct ExtendedData: Decodable {
        public let notes: String?
        public let tags: [String]?
        public let description: String?
    }
    
    public let setID: Int
    public let number: String
    public let numberVariant: Int
    public let name: String
    public let year: Int
    public let theme: String
    public let themeGroup: String
    public let subtheme: String?
    public let category: String
    public let released: Bool
    public let pieces: Int?
    public let minifigs: Int?
    public let image: Image
    public let bricksetURL: URL
    public let collection: Collection
    public let collections: Collections
    public let LEGOCom: LEGOCom
    public let rating: Double
    public let reviewCount: Int
    public let packagingType: String
    public let availability: String
    public let instructionsCount: Int
    public let additionalImageCount: Int
    public let ageRange: AgeRange
    public let dimensions: Dimensions
    public let barcode: Barcodes
    public let extendedData: ExtendedData
    public let lastUpdated: Date
}
