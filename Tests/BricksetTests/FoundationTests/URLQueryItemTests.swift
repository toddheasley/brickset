import Testing
@testable import Brickset
import Foundation

struct URLQueryItemTests {
    @Test func params() throws {
        #expect(try URLQueryItem.params(GetSets(setNumber: "6692-1")) == URLQueryItem(name: "params", value: "{'setNumber':'6692-1'}"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.params(GetSets())
        }
    }
    
    @Test func theme() throws {
        #expect(try URLQueryItem.theme("city") == URLQueryItem(name: "theme", value: "city"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.theme("")
        }
    }
    
    @Test func minifigNumber() throws {
        #expect(try URLQueryItem.minifig(number: "567497") == URLQueryItem(name: "minifigNumber", value: "567497"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.minifig(number: "")
        }
    }
    
    @Test func setNumber() throws {
        #expect(try URLQueryItem.set(number: "6692-1") == URLQueryItem(name: "setNumber", value: "6692-1"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.set(number: "")
        }
    }
    
    @Test func setID() {
        #expect(URLQueryItem.set(id: 567497) == URLQueryItem(name: "setID", value: "567497"))
    }
    
    @Test func username() throws {
        #expect(try URLQueryItem.username("toddheasley") == URLQueryItem(name: "username", value: "toddheasley"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.username("")
        }
    }
    
    @Test func password() throws {
        #expect(try URLQueryItem.password("P@ssw0rd") == URLQueryItem(name: "password", value: "P@ssw0rd"))
        #expect(throws: Error.self) {
            _ = try URLQueryItem.password("")
        }
    }
    
    @Test func userHash() throws {
        try URLCredentialStorage.shared.setUserHash("H@SH", username: "toddheasley")
        #expect(try URLQueryItem.userHash() == URLQueryItem(name: "userHash", value: "H@SH"))
        try URLCredentialStorage.shared.setUserHash(nil)
        #expect(throws: Error.self) {
            _ = try URLQueryItem.userHash()
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
