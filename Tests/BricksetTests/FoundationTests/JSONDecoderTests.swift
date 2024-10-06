import Testing
@testable import Brickset
import Foundation

struct JSONDecoderTests {
    @Test func decode() throws {
        
    }
    
    @Test func checkData() throws {
        var data: Data = try JSONSerialization.data(withJSONObject: [
            "status": "success"
        ])
        try #require(try JSONDecoder().check(data))
        data = try JSONSerialization.data(withJSONObject: [
            "status": "error",
            "message": "Invalid API key"
        ])
        #expect(throws: Error.self) {
            try JSONDecoder().check(data)
        }
        data = try JSONSerialization.data(withJSONObject: [
            "status": "error"
        ])
        #expect(throws: URLError.self) {
            try JSONDecoder().check(data)
        }
        data = try JSONSerialization.data(withJSONObject: [:])
        #expect(throws: URLError.self) {
            try JSONDecoder().check(data)
        }
    }
    
    @Test func checkJSONObject() throws {
        try #require(try JSONDecoder().check([
            "status": "success"
        ]))
        #expect(throws: Error.self) {
            try JSONDecoder().check([
                "status": "error",
                "message": "Invalid API key"
            ])
        }
        #expect(throws: URLError.self) {
            try JSONDecoder().check([
                "status": "error"
            ])
        }
        #expect(throws: URLError.self) {
            try JSONDecoder().check([:])
        }
    }
}
