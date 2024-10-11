import Testing
@testable import Brickset

struct StringTests {
    
    // MARK: Codable
    @Test func redacted() {
        #expect("3-26cC-J3gUn-63bi".redacted(false) == "3-26cC-J3gUn-63bi")
        #expect("3-26cC-J3gUn-63bi".redacted(with: "*") == "*****************")
        #expect("3-26cC-J3gUn-63bi".redacted() == "•••••••••••••••••")
    }
}
