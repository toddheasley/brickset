import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, key: String) throws -> (T, Int?)  {
        guard let jsonObject: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw URLError(.cannotDecodeContentData)
        }
        try check(jsonObject)
        guard let object: [Any] = jsonObject[key] as? [Any]  else {
            throw URLError(.cannotDecodeContentData)
        }
        let data: Data = try JSONSerialization.data(withJSONObject: object)
        let t: T = try decode(type, from: data)
        return (t, jsonObject["matches"] as? Int)
    }
    
    func check(_ data: Data) throws {
        try check(try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:])
    }
    
    func check(_ jsonObject: [String: Any]) throws {
        switch jsonObject["status"] as? String {
        case "success":
            break
        case "error":
            guard let message: String = jsonObject["message"] as? String,
                  let error: Error = Error(rawValue: message) else {
                fallthrough
            }
            throw error
        default:
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    convenience init(_ dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static var format: Self {
        .custom({ decoder in
            let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
            let string: String = try container.decode(String.self).replacingOccurrences(of: "Z", with: "").components(separatedBy: ".")[0]
            return DateFormatter.format.date(from: string) ?? Date(timeIntervalSince1970: 0.0)
        })
    }
}
