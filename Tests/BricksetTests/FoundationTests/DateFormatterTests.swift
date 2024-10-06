import Testing
@testable import Brickset
import Foundation

struct DateFormatterTests {
    @Test func params() {
        #expect(DateFormatter.params.dateFormat == "yyyy-MM-dd")
        #expect(DateFormatter.params.timeZone.secondsFromGMT() == 0)
        #expect(DateFormatter.params.locale == .posix)
    }
}

struct LocaleTests {
    @Test func posix() {
        #expect(Locale.posix.identifier == "en_US_POSIX")
    }
}
