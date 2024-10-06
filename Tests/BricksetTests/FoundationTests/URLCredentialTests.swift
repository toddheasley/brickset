import Testing
@testable import Brickset
import Foundation

struct URLCredentialTests {
    @Test func userHash() throws {
        #expect(try URLCredential(user: "toddheasley", hash: "P@ssw0rd").userHash() == ("toddheasley", "P@ssw0rd"))
    }
    
    @Test func userHashInit() throws {
        #expect(try URLCredential(user: "toddheasley", hash: "P@ssw0rd") == URLCredential(user: "toddheasley", password: "P@ssw0rd", persistence: URLCredential.persistence))
    }
}

struct URLCredentialStorageTests {
    @Test func userHash() {
        URLCredentialStorage.shared.userHash = ("toddheasley", "P@ssw0rd")
        #expect(URLCredentialStorage.shared.userHash?.name == "toddheasley")
        #expect(URLCredentialStorage.shared.userHash?.hash == "P@ssw0rd")
        URLCredentialStorage.shared.userHash = nil
        #expect(URLCredentialStorage.shared.userHash == nil)
    }
}

struct URLProtectionSpaceTests {
    @Test func brickset() {
        #expect(URLProtectionSpace.brickset.receivesCredentialSecurely)
        #expect(URLProtectionSpace.brickset.host == "api.brickset")
    }
}
