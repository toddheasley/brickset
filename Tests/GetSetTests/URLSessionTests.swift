import Foundation
@testable import GetSet
import Testing

struct URLSessionTests {
    @Test(.enabled(if: isTestable)) func checkKey() async throws {
        try await URLSession.shared.checkKey()
        try URLCredentialStorage.shared.setAPIKey(nil)
        await #expect(throws: Error.self) {
            try await URLSession.shared.checkKey()
        }
    }
    
    @Test(.enabled(if: isTestable)) func getKeyUsageStats() async throws {
        _ = try await URLSession.shared.getKeyUsageStats()
    }
    
    @Test(.enabled(if: isTestable)) func getSets() async throws {
        #expect(Bool(false))
        /*
        let params: GetSets = GetSets(query: "train", orderBy: .YearFromDESC, pageSize: 100)
        let sets: ([Sets], Int?) = try await URLSession.shared.getSets(params)
        #expect(!sets.0.isEmpty)
        #expect(sets.0.count <= sets.1 ?? 0) */
    }
    
    @Test(.enabled(if: isTestable)) func getAdditionalImages() async throws {
        let additionalImages: ([Sets.Image], Int?) = try await URLSession.shared.getAdditionalImages(set: 33645)
        #expect(!additionalImages.0.isEmpty)
        #expect(additionalImages.0.count <= additionalImages.1 ?? 0)
    }
    
    @Test(.enabled(if: isTestable)) func getInstructions() async throws {
        let instructions: ([Instructions], Int?) = try await URLSession.shared.getInstructions(set: 33645)
        #expect(!instructions.0.isEmpty)
        #expect(instructions.0.count <= instructions.1 ?? 0)
    }
    
    @Test(.enabled(if: isTestable)) func getInstructionsSetNumber() async throws {
        let instructions: ([Instructions], Int?) = try await URLSession.shared.getInstructions(set: "60336-1")
        #expect(!instructions.0.isEmpty)
        #expect(instructions.0.count <= instructions.1 ?? 0)
    }
    
    init() throws {
        try URLCredentialStorage.shared.setAPIKey(apiKey)
    }
}

private var isTestable: Bool { apiKey != testAPIKey }

private let testAPIKey: String = "3-26cC-J3gUn-63bi"
private let apiKey: String = testAPIKey
