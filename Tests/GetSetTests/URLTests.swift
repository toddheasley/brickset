import Foundation
@testable import GetSet
import Testing

struct URLTests {
    @Test func api() {
        #expect(URL(string: "https://brickset.com/api/v3.asmx") == .api)
    }
    
    @Test func apiMethod() throws {
        try URLCredentialStorage.shared.setAPIKey("3-26cC-J3gUn-63bi")
        #expect(try URL.api("method") == URL(string: "https://brickset.com/api/v3.asmx/method?apiKey=3-26cC-J3gUn-63bi"))
        #expect(try URL.api("getAdditionalImages", query: [
            .set(id: 567497)
        ]) == URL(string: "https://brickset.com/api/v3.asmx/getAdditionalImages?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(throws: URLError.self) {
            _ = try URL.api("")
        }
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URL.api("method")
        }
    }
}
