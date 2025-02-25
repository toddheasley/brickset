import Foundation
@testable import GetSet
import Testing

struct URLRequestTests {
    @Test func checkKey() throws {
        let request: URLRequest = try .checkKey()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/checkKey?apiKey=3-26cC-J3gUn-63bi"))
        #expect(request.httpMethod == "GET")
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.checkKey()
        }
    }
    
    @Test func getKeyUsageStats() throws {
        let request: URLRequest = try .getKeyUsageStats()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getKeyUsageStats?apiKey=3-26cC-J3gUn-63bi"))
        #expect(request.httpMethod == "GET")
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.getKeyUsageStats()
        }
    }
    
    @Test func getSets() throws {
        let request: URLRequest = try .getSets(.setID(567497))
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash&params=%7B'setID':567497%7D"))
        #expect(request.httpMethod == "GET")
        #expect(try URLRequest.getSets(.query("cargo train")).url == URL(string: "https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash&params=%7B'orderBy':'YearFromDESC','query':'cargo%20train'%7D"))
        #expect(throws: Error.self) {
            _ = try URLRequest.getSets(.setNumber(""))
        }
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.getSets(.setID(567497))
        }
        
        
        // https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash=H@SH&params=%7B'setID':567497%7D
        // https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash=&params=%7B'setID':567497%7D
        // https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash=&params=%7B'setID':567497%7D)
    }
    
    @Test func getAdditionalImages() throws {
        let request: URLRequest = try .getAdditionalImages(set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getAdditionalImages?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(request.httpMethod == "GET")
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.getAdditionalImages(set: 567497)
        }
    }
    
    @Test func getInstructions() throws {
        let request: URLRequest = try .getInstructions(set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getInstructions?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(request.httpMethod == "GET")
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: 567497)
        }
    }
    
    @Test func getInstructionsSetNumber() throws {
        let request: URLRequest = try .getInstructions(set: "6692-1")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getInstructions2?apiKey=3-26cC-J3gUn-63bi&setNumber=6692-1"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: "")
        }
        try URLCredentialStorage.shared.setAPIKey(nil)
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: "6692-1")
        }
    }
    
    init() throws {
        try URLCredentialStorage.shared.setAPIKey(testAPIKey)
    }
}

private let testAPIKey: String = "3-26cC-J3gUn-63bi"
#if os(macOS)
private let isKeychainTestable: Bool  = true
#else
private let isKeychainTestable: Bool  = false
#endif
