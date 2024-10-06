import Foundation

public protocol Params: Encodable {
    var value: String { get }
}

extension Params {
    
    // MARK: Params
    public var value: String {
        String(data: try! JSONEncoder.sortedKeys.encode(self), encoding: .utf8)!.replacingOccurrences(of: "\"", with: "'")
    }
}

public struct GetSets: Params {
    public let setID: Int?
    public let query: String?
    public let theme: [String]
    public let subtheme: [String]
    public let setNumber: String?
    public let year: [Int]
    public let tag: String?
    public let owned: Bool?
    public let wanted: Bool?
    public let updatedSince: Date?
    public let orderBy: Order?
    public let pageSize: Int? // Default: 20; limit: 500
    public let pageNumber: Int? // Default: 1
    public let extendedData: Bool?
    
    public init(setID: Int? = nil, query: String? = nil, theme: [String] = [], subtheme: [String] = [], setNumber: String? = nil, year: [Int] = [], tag: String? = nil, owned: Bool? = nil, wanted: Bool? = nil, updatedSince: Date? = nil, orderBy: Order? = nil, pageSize: Int? = nil, pageNumber: Int? = nil, extendedData: Bool? = nil) {
        self.setID = setID
        self.query = query
        self.theme = theme
        self.subtheme = subtheme
        self.setNumber = setNumber
        self.year = year
        self.tag = tag
        self.owned = owned
        self.wanted = wanted
        self.updatedSince = updatedSince
        self.orderBy = orderBy
        self.pageSize = pageSize
        self.pageNumber = pageNumber
        self.extendedData = extendedData
    }
    
    // MARK: Params
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encodeIfPresent(setID, forKey: .setID)
        try container.encodeIfPresent(query, forKey: .query)
        if !theme.isEmpty {
            try container.encode(theme.joined(separator: ","), forKey: .theme)
        }
        if !subtheme.isEmpty {
            try container.encode(subtheme.joined(separator: ","), forKey: .subtheme)
        }
        try container.encodeIfPresent(setNumber, forKey: .setNumber)
        if !year.isEmpty {
            try container.encode(year.map { "\($0)" }.joined(separator: ","), forKey: .year)
        }
        try container.encodeIfPresent(tag, forKey: .tag)
        try container.encodeIfPresent(owned ?? false ? 1 : nil, forKey: .owned)
        try container.encodeIfPresent(wanted ?? false ? 1 : nil, forKey: .wanted)
        if let updatedSince {
            try container.encode(DateFormatter.params.string(from: updatedSince), forKey: .updatedSince)
        }
        try container.encodeIfPresent(orderBy, forKey: .orderBy)
        try container.encodeIfPresent(pageSize, forKey: .pageSize)
        try container.encodeIfPresent(pageNumber, forKey: .pageNumber)
        try container.encodeIfPresent(extendedData ?? false ? 1 : nil, forKey: .extendedData)
    }
    
    private enum Key: CodingKey {
        case setID, query, theme, subtheme, setNumber, year, tag, owned, wanted, updatedSince, orderBy, pageSize, pageNumber, extendedData
    }
}

public struct SetCollection: Params {
    public let own: Bool?
    public let want: Bool?
    public let qtyOwned: Int? // Default: 0; limit: 999
    public let notes: String? // Limit: 1000 characters
    public let rating: Int? // 1-5
    
    public init(own: Bool? = nil, want: Bool? = nil, qtyOwned: Int? = nil, notes: String? = nil, rating: Int? = nil) {
        self.own = own
        self.want = want
        self.qtyOwned = qtyOwned
        self.notes = notes
        self.rating = rating
    }
    
    // MARK: Params
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        if let own {
            try container.encode(own ? 1 : 0, forKey: .own)
        }
        if let want {
            try container.encode(want ? 1 : 0, forKey: .want)
        }
        try container.encodeIfPresent(qtyOwned, forKey: .qtyOwned)
        try container.encodeIfPresent(notes, forKey: .notes)
        try container.encodeIfPresent(rating, forKey: .rating)
    }
    
    private enum Key: CodingKey {
        case own, want, qtyOwned, notes, rating
    }
}

public struct GetMinifigCollection: Params {
    public let owned: Bool?
    public let wanted: Bool?
    public let query: String?
    
    public init(owned: Bool? = nil, wanted: Bool? = nil, query: String? = nil) {
        self.owned = owned
        self.wanted = wanted
        self.query = query
    }
    
    // MARK: Params
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        if let owned {
            try container.encode(owned ? 1 : 0, forKey: .owned)
        }
        if let wanted {
            try container.encode(wanted ? 1 : 0, forKey: .wanted)
        }
        if let query {
            try container.encode(query.isEmpty ? " " : query, forKey: .query)
        } else if !(owned ?? false) && !(wanted ?? false) {
            try container.encode(" ", forKey: .query)
        }
    }
    
    private enum Key: CodingKey {
        case owned, wanted, query
    }
}

public struct SetMinifigCollection: Params {
    public let own: Bool?
    public let want: Bool?
    public let qtyOwned: Int? // Default: 0; limit: 999
    public let notes: String? // Limit: 1000 characters
    
    public init(own: Bool? = nil, want: Bool? = nil, qtyOwned: Int? = nil) {
        self.own = own
        self.want = want
        self.qtyOwned = qtyOwned
        notes = nil
    }
    
    public init(notes: String?) {
        self.notes = notes ?? ""
        own = nil
        want = nil
        qtyOwned = nil
    }
    
    // MARK: Params
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        if let notes {
            try container.encode(notes.isEmpty ? " " : notes, forKey: .notes)
        } else {
            if let own {
                try container.encode(own ? 1 : 0, forKey: .own)
            }
            if let want {
                try container.encode(want ? 1 : 0, forKey: .want)
            }
            try container.encodeIfPresent(qtyOwned, forKey: .qtyOwned)
        }
    }
    
    private enum Key: CodingKey {
        case own, want, qtyOwned, notes
    }
}
