import Foundation
@testable import GetSet
import Testing

struct DateFormatterTests {
    @Test func params() {
        #expect(DateFormatter.params.dateFormat == "yyyy-MM-dd")
        #expect(DateFormatter.params.timeZone.secondsFromGMT() == 0)
        #expect(DateFormatter.params.locale == .posix)
    }
    
    @Test func posixLocale() {
        #expect(Locale.posix.identifier == "en_US_POSIX")
    }
}
