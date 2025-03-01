import Foundation

public struct Sets: Decodable, CustomStringConvertible {
    public struct Image: Decodable {
        public let thumbnailURL: URL?
        public let imageURL: URL?
        
        public init(_ imageURL: URL) {
            self.imageURL = imageURL
            thumbnailURL = nil
        }
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
    
    public struct AgeRange: Decodable, CustomStringConvertible {
        public let min: Int?
        public let max: Int?
        
        // MARK: CustomStringConvertible
        public var description: String { min != nil ? "\(min!)\(max != nil ? "-\(max!)" : "+")" : "" }
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
    public let LEGOCom: LEGOCom
    public let packagingType: String
    public let availability: String
    public let instructionsCount: Int
    public let additionalImageCount: Int
    public let ageRange: AgeRange
    public let dimensions: Dimensions
    public let barcode: Barcodes
    
    public var path: String { "\(number)-\(numberVariant)" }
    
    // MARK: CustomStringConvertible
    public var description: String { "\(path) \(name)" }
}
