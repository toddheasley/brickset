import Testing
@testable import Brickset
import Foundation

struct URLSessionTests {
    @Test(isEnabled) func checkKey() async throws {
        try #require(try await URLSession.shared.checkKey())
        try URLCredentialStorage.shared.setAPIKey(nil)
        await #expect(throws: Error.self) {
            try await URLSession.shared.checkKey()
        }
    }
    
    @Test(isEnabled) func login() async throws {
        try URLCredentialStorage.shared.setUserHash(nil)
        try #require(try await URLSession.shared.login(username, password: password))
        #expect(URLCredentialStorage.shared.userHash?.username == "toddheasley")
        #expect(!(URLCredentialStorage.shared.userHash?.hash.isEmpty ?? true))
        await #expect(throws: Error.self) {
            try await URLSession.shared.login(username, password: "")
        }
        try URLCredentialStorage.shared.setAPIKey(nil)
        await #expect(throws: Error.self) {
            try await URLSession.shared.login(username, password: password)
        }
    }
    
    @Test(isEnabled) func checkUserHash() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        try #require(try await URLSession.shared.checkUserHash())
        try URLCredentialStorage.shared.setUserHash("H@SH", username: username)
        await #expect(throws: Error.self) {
            try await URLSession.shared.checkUserHash()
        }
        try URLCredentialStorage.shared.setUserHash(nil)
        await #expect(throws: Error.self) {
            try await URLSession.shared.checkUserHash()
        }
        try URLCredentialStorage.shared.setAPIKey(nil)
    }
    
    @Test(isEnabled) func getKeyUsageStats() async throws {
        _ = try #require(try await URLSession.shared.getKeyUsageStats())
    }
    
    @Test(isEnabled) func getSets() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        let params: GetSets = GetSets(query: "train", orderBy: .YearFromDESC, pageSize: 100)
        let sets: ([Sets], Int?) = try #require(try await URLSession.shared.getSets(params))
        #expect(!sets.0.isEmpty)
        #expect(sets.0.count <= sets.1 ?? 0)
    }
    
    @Test(isEnabled) func getAdditionalImages() async throws {
        let additionalImages: ([Sets.Image], Int?) = try #require(try await URLSession.shared.getAdditionalImages(set: 33645))
        #expect(!additionalImages.0.isEmpty)
        #expect(additionalImages.0.count <= additionalImages.1 ?? 0)
    }
    
    @Test(isEnabled) func getInstructions() async throws {
        let instructions: ([Instructions], Int?) = try #require(try await URLSession.shared.getInstructions(set: 33645))
        #expect(!instructions.0.isEmpty)
        #expect(instructions.0.count <= instructions.1 ?? 0)
    }
    
    @Test(isEnabled) func getInstructionsSetNumber() async throws {
        let instructions: ([Instructions], Int?) = try #require(try await URLSession.shared.getInstructions(set: "60336-1"))
        #expect(!instructions.0.isEmpty)
        #expect(instructions.0.count <= instructions.1 ?? 0)
    }
    
    @Test(isEnabled) func getReviews() async throws {
        let reviews: ([Reviews], Int?) = try #require(try await URLSession.shared.getReviews(set: 33706))
        #expect(!reviews.0.isEmpty)
        #expect(reviews.0.count <= reviews.1 ?? 0)
    }
    
    @Test(isEnabled) func getThemes() async throws {
        let themes: ([Themes], Int?) = try #require(try await URLSession.shared.getThemes())
        #expect(!themes.0.isEmpty)
        #expect(themes.0.count == themes.1 ?? 0)
    }
    
    @Test(isEnabled) func getSubthemes() async throws {
        let subthemes: ([Subthemes], Int?) = try #require(try await URLSession.shared.getSubthemes("World City"))
        #expect(!subthemes.0.isEmpty)
        #expect(subthemes.0.count == subthemes.1 ?? 0)
    }
    
    @Test(isEnabled) func setCollection() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        try #require(try await URLSession.shared.setCollection(SetCollection(own: true, notes: "Favorite LEGO set, all time", rating: 5), set: 33645))
    }
    
    @Test(isEnabled) func getUserNotes() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        let userNotes: ([UserNotes], Int?) = try #require(try await URLSession.shared.getUserNotes())
        #expect(!userNotes.0.isEmpty)
        #expect(userNotes.0.count <= userNotes.1 ?? 0)
    }
    
    @Test(isEnabled) func getMinifigCollection() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        let minifigCollection: ([MinifigCollection], Int?) = try #require(try await URLSession.shared.getMinifigCollection(GetMinifigCollection(query: "train")))
        #expect(!minifigCollection.0.isEmpty)
        #expect(minifigCollection.0.count <= minifigCollection.1 ?? 0)
    }
    
    @Test(isEnabled) func setMinifigCollection() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        try #require(try await URLSession.shared.setMinifigCollection(SetMinifigCollection(own: true), set: "col445"))
        try #require(try await URLSession.shared.setMinifigCollection(SetMinifigCollection(notes: "Favorite fig from the last series"), set: "col445"))
    }
    
    @Test(isEnabled) func getUserMinifigNotes() async throws {
        try #require(try await URLSession.shared.login(username, password: password))
        try #require(try await URLSession.shared.setMinifigCollection(SetMinifigCollection(notes: "Favorite fig from the last series"), set: "col445"))
        let userMinifigNotes: ([UserMinifigNotes], Int?) = try #require(try await URLSession.shared.getUserMinifigNotes())
        #expect(!userMinifigNotes.0.isEmpty)
        #expect(userMinifigNotes.0.count <= userMinifigNotes.1 ?? 0)
    }
    
    init() throws {
        try URLCredentialStorage.shared.setAPIKey(apiKey)
    }
}

private var isEnabled: ConditionTrait {
    .enabled(if: apiKey != testAPIKey && !username.isEmpty && !password.isEmpty)
}

private let testAPIKey: String = "3-26cC-J3gUn-63bi"
private let apiKey: String = testAPIKey
private let username: String = ""
private let password: String = ""
