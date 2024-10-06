import Foundation

extension JSONEncoder {
    static let sortedKeys: JSONEncoder = JSONEncoder(outputFormatting: .sortedKeys)
    
    private convenience init(outputFormatting: OutputFormatting) {
        self.init()
        self.outputFormatting = outputFormatting
    }
}
