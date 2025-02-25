import Foundation

extension JSONEncoder {
    static let sortedKeys: JSONEncoder = JSONEncoder(outputFormatting: .sortedKeys)
    
    func params<T>(_ value: T) throws -> String where T : Encodable {
        let data: Data = try encode(value)
        guard let string: String = String(data: data, encoding: .utf8) else {
            throw Error.parameterError
        }
        return string.replacingOccurrences(of: "\"", with: "'")
    }
    
    private convenience init(outputFormatting: OutputFormatting) {
        self.init()
        self.outputFormatting = outputFormatting
    }
}
