import Foundation

public enum Params: Encodable {
    case query(String)
    case setNumber(String)
    case setID(Int)
    
    // MARK: Encodable
    public func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        switch self {
        case .query(let query):
            guard !query.isEmpty else {
                throw Error.parameterError
            }
            try container.encode(query, forKey: .query)
            try container.encode("YearFromDESC", forKey: .orderBy)
        case .setNumber(let number):
            guard !number.isEmpty else {
                throw Error.parameterError
            }
            try container.encode(number, forKey: .setNumber)
        case .setID(let id):
            guard id >= 0 else {
                throw Error.parameterError
            }
            try container.encode(id, forKey: .setID)
        }
    }
    
    private enum Key: CodingKey {
        case query, setNumber, setID, orderBy
    }
}
