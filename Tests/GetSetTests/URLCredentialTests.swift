import Foundation
@testable import GetSet
import Testing

struct URLCredentialTests {
    @Test func apiKey() throws {
        #expect(try URLCredential.api("@P1K3Y").password == "@P1K3Y")
        #expect(try URLCredential.api("@P1K3Y").user == "api.brickset")
        #expect(try URLCredential.api("@P1K3Y", persistence: .synchronizable).persistence == .synchronizable)
        #expect(try URLCredential.api("@P1K3Y").persistence == .forSession)
        #expect(throws: Error.self) {
            try URLCredential.api("")
        }
    }
}

struct URLCredentialStorageTests {
    @Test(.enabled(if: isKeychainTestable)) func apiKey() throws {
        try URLCredentialStorage.shared.setAPIKey("@P1K3Y", persistence: .permanent)
        #expect(URLCredentialStorage.shared.apiKey == "@P1K3Y")
        try URLCredentialStorage.shared.setAPIKey("@P1K3Y", persistence: .none)
        #expect(URLCredentialStorage.shared.apiKey == nil)
        try URLCredentialStorage.shared.setAPIKey("@P1K3Y")
        #expect(URLCredentialStorage.shared.apiKey == "@P1K3Y")
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(URLCredentialStorage.shared.apiKey == nil)
    }
}

struct URLProtectionSpaceTests {
    @Test func brickset() {
        #expect(URLProtectionSpace.api.receivesCredentialSecurely)
        #expect(URLProtectionSpace.api.host == "api.brickset")
    }
}

#if os(macOS)
private let isKeychainTestable: Bool  = true
#else
private let isKeychainTestable: Bool  = false
#endif
