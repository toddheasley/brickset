import Foundation
@testable import GetSet
import Testing

struct URLQueryItemTests {
    @Test func params() throws {
        #expect(try URLQueryItem.params(.query("cargo train")) == URLQueryItem(name: "params", value: "{'orderBy':'YearFromDESC','query':'cargo train'}"))
        #expect(try URLQueryItem.params(.setNumber("6692-1")) == URLQueryItem(name: "params", value: "{'setNumber':'6692-1'}"))
        #expect(try URLQueryItem.params(.setID(0)) == URLQueryItem(name: "params", value: "{'setID':0}"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.params(.setNumber(""))
        }
    }
    
    @Test func setNumber() throws {
        #expect(try URLQueryItem.set(number: "6692-1") == URLQueryItem(name: "setNumber", value: "6692-1"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.set(number: "")
        }
    }
    
    @Test func setID() throws {
        #expect(try URLQueryItem.set(id: 567497) == URLQueryItem(name: "setID", value: "567497"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.set(id: -1)
        }
    }
    
    @Test func apiKey() throws {
        try URLCredentialStorage.shared.setAPIKey("3-26cC-J3gUn-63bi")
        #expect(try URLQueryItem.apiKey() == URLQueryItem(name: "apiKey", value: "3-26cC-J3gUn-63bi"))
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLQueryItem.apiKey()
        }
    }
}

#if os(macOS)
private let isKeychainTestable: Bool  = true
#else
private let isKeychainTestable: Bool  = false
#endif
