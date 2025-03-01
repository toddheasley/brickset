import Foundation

extension DateFormatter {
    static let format: DateFormatter = .gmt("yyyy-MM-dd'T'HH:mm:ss")
    static let params: DateFormatter = .gmt("yyyy-MM-dd")
    
    private static func gmt(_ format: String? = nil) -> Self {
        let formatter: Self = Self()
        formatter.locale = .posix
        formatter.timeZone = .gmt
        formatter.dateFormat = format ?? formatter.dateFormat
        return formatter
    }
}

extension Locale {
    static let posix: Self = Self(identifier: "en_US_POSIX")
}
