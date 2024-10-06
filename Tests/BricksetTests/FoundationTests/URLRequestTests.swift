import Testing
@testable import Brickset
import Foundation

extension URLRequest {
    static let testAPIKey: String = "3-26cC-J3gUn-63bi"
    static var isTestAPIKey: Bool { apiKey == testAPIKey }
}

struct URLRequestTests {
    @Test func apiKey() {
        URLRequest.apiKey = ""
        #expect(URLRequest.apiKey == nil)
        URLRequest.apiKey = URLRequest.testAPIKey
        #expect(URLRequest.apiKey == URLRequest.testAPIKey)
        URLRequest.apiKey = nil
        #expect(URLRequest.apiKey == nil)
    }
    
    @Test func checkKey() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .checkKey()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/checkKey?apiKey=3-26cC-J3gUn-63bi"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.checkKey()
        }
    }
    
    @Test func login() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .login("toddheasley", password: "P@ssw0rd")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/login?apiKey=3-26cC-J3gUn-63bi&username=toddheasley&password=P@ssw0rd"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.login("toddheasley", password: "")
        }
        #expect(throws: Error.self) {
            _ = try URLRequest.login("", password: "P@ssw0rd")
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.login("toddheasley", password: "P@ssw0rd")
        }
    }
    
    @Test func checkUserHash() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        let request: URLRequest = try .checkUserHash()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/checkUserHash?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH"))
        #expect(request.httpMethod == "GET")
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.checkUserHash()
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.checkUserHash()
        }
    }
    
    @Test func getKeyUsageStats() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getKeyUsageStats()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getKeyUsageStats?apiKey=3-26cC-J3gUn-63bi"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getKeyUsageStats()
        }
    }
    
    @Test func getSets() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        let request: URLRequest = try .getSets(GetSets(setID: 567497))
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'setID':567497%7D"))
        #expect(request.httpMethod == "GET")
        #expect(try URLRequest.getSets(GetSets(query: "train", updatedSince: Date(timeIntervalSince1970: 0.0))).url == URL(string: "https://brickset.com/api/v3.asmx/getSets?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'query':'train','updatedSince':'1970-01-01'%7D"))
        #expect(throws: Error.self) {
            _ = try URLRequest.getSets(GetSets())
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getSets(GetSets(setID: 567497))
        }
    }
    
    @Test func getAdditionalImages() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getAdditionalImages(set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getAdditionalImages?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getAdditionalImages(set: 567497)
        }
    }
    
    @Test func getInstructions() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getInstructions(set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getInstructions?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: 567497)
        }
    }
    
    @Test func getInstructionsSetNumber() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getInstructions(set: "6692-1")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getInstructions2?apiKey=3-26cC-J3gUn-63bi&setNumber=6692-1"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: "")
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getInstructions(set: "6692-1")
        }
    }
    
    @Test func getReviews() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getReviews(set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getReviews?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getReviews(set: 567497)
        }
    }
    
    @Test func getThemes() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getThemes()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getThemes?apiKey=3-26cC-J3gUn-63bi"))
        #expect(request.httpMethod == "GET")
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getThemes()
        }
    }
    
    @Test func getSubthemes() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getSubthemes("city")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getSubthemes?apiKey=3-26cC-J3gUn-63bi&theme=city"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.getSubthemes("")
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getSubthemes("city")
        }
    }
    
    @Test func getYears() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getYears("city")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getYears?apiKey=3-26cC-J3gUn-63bi&theme=city"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.getYears("")
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getYears("city")
        }
    }
    
    @Test func setCollection() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        let request: URLRequest = try .setCollection(SetCollection(rating: 4), set: 567497)
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/setCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'rating':4%7D&setID=567497"))
        #expect(request.httpMethod == "GET")
        #expect(throws: Error.self) {
            _ = try URLRequest.setCollection(SetCollection(), set: 567497)
        }
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.setCollection(SetCollection(rating: 4), set: 567497)
        }
        URLRequest.apiKey = nil
    }
    
    @Test func getUserNotes() throws {
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        #expect(throws: Error.self) {
            _ = try URLRequest.getUserNotes()
        }
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getUserNotes()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getUserNotes?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH"))
        #expect(request.httpMethod == "GET")
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getUserNotes()
        }
        URLRequest.apiKey = nil
    }
    
    @Test func getMinifigCollection() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        var request: URLRequest = try .getMinifigCollection(GetMinifigCollection(owned: true))
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getMinifigCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'owned':1%7D"))
        #expect(request.httpMethod == "GET")
        request = try URLRequest.getMinifigCollection(GetMinifigCollection(query: "train"))
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getMinifigCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'query':'train'%7D"))
        request = try URLRequest.getMinifigCollection(GetMinifigCollection())
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getMinifigCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'query':'%20'%7D"))
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getMinifigCollection(GetMinifigCollection())
        }
        URLRequest.apiKey = nil
    }
    
    @Test func setMinifigCollection() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        var request: URLRequest = try .setMinifigCollection(SetMinifigCollection(notes: "Factory sealed with misprint on package"), minifig: "567497")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/setMinifigCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B'notes':'Factory%20sealed%20with%20misprint%20on%20package'%7D&minifigNumber=567497"))
        #expect(request.httpMethod == "GET")
        request = try URLRequest.setMinifigCollection(SetMinifigCollection(), minifig: "567497")
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/setMinifigCollection?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH&params=%7B%7D&minifigNumber=567497"))
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.setMinifigCollection(SetMinifigCollection(want: true), minifig: "567497")
        }
        URLRequest.apiKey = nil
    }
    
    @Test func getUserMinifigNotes() throws {
        URLCredentialStorage.shared.userHash = ("toddheasley", "USERHASHUSERHASH")
        #expect(throws: Error.self) {
            _ = try URLRequest.getUserMinifigNotes()
        }
        URLRequest.apiKey = URLRequest.testAPIKey
        let request: URLRequest = try .getUserMinifigNotes()
        #expect(request.url == URL(string: "https://brickset.com/api/v3.asmx/getUserMinifigNotes?apiKey=3-26cC-J3gUn-63bi&userHash=USERHASHUSERHASH"))
        #expect(request.httpMethod == "GET")
        URLCredentialStorage.shared.userHash = nil
        #expect(throws: Error.self) {
            _ = try URLRequest.getUserMinifigNotes()
        }
        URLRequest.apiKey = nil
    }
}

struct URLTests {
    @Test func api() {
        #expect(URL(string: "https://brickset.com/api/v3.asmx") == .api)
    }
    
    @Test func apiMethod() throws {
        URLRequest.apiKey = URLRequest.testAPIKey
        #expect(try URL.api("method") == URL(string: "https://brickset.com/api/v3.asmx/method?apiKey=3-26cC-J3gUn-63bi"))
        #expect(try URL.api("getAdditionalImages", query: [
            .set(id: 567497)
        ]) == URL(string: "https://brickset.com/api/v3.asmx/getAdditionalImages?apiKey=3-26cC-J3gUn-63bi&setID=567497"))
        #expect(throws: URLError.self) {
            _ = try URL.api("")
        }
        URLRequest.apiKey = nil
        #expect(throws: Error.self) {
            _ = try URL.api("method")
        }
    }
}
