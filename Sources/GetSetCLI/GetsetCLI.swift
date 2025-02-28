import ArgumentParser
import Foundation
import GetSet

@main
struct GetsetCLI: AsyncParsableCommand {
    struct Get: AsyncParsableCommand {
        @Argument(help: "Query by set number, name or keyword(s).") var query: String?
        @Flag(name: .shortAndLong, help: "Save images and building instructions.") var download: Bool = false
        
        // MARK: AsyncParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Get set info, images and instructions.", discussion: [
            "Matching sets open in browser tabs.",
            "",
            "DOWNLOADS: \(URL.downloads.relativePath)"
        ].joined(separator: "\n"))
        
        func run() async throws {
            if let params: Params = Params(query) {
                let sets: [Sets] = try await URLSession.shared.getSets(params).0
                if !sets.isEmpty {
                    for set in sets {
                        let url: URL = try await URLSession.shared.getSet(set, download: download)
                        open(url: url.deletingLastPathComponent())
                        open(url: url)
                    }
                } else {
                    print("Set not found")
                }
            } else {
                print("Query not found")
            }
        }
    }
    
    struct Key: AsyncParsableCommand {
        @Argument(help: "Set API key.") var key: String?
        @Flag(name: .shortAndLong, help: "Show key in plain text.") var show: Bool = false
        @Flag(name: .shortAndLong, help: "Request API key from brickset.com.") var request: Bool = false
        @Flag(name: .shortAndLong, help: "Delete key from keychain.") var delete: Bool = false
        
        // MARK: AsyncParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Manage Brickset API key.", discussion: "Setting a key for use with this command-line interface stores it securely in macOS keychain.")
        
        func run() async throws {
            if let key, !key.isEmpty {
                try URLCredentialStorage.shared.setAPIKey(key, persistence: .permanent)
            }
            if delete {
                try URLCredentialStorage.shared.setAPIKey(nil)
            }
            if request {
                open(true, url: .requestAPIKey)
            } else if let key = URLCredentialStorage.shared.apiKey {
                let status: APIKeyStatus = await .current
                print("API key: \(key.redacted(!show).colorCoded(for: status))")
            } else {
                print("API key not set")
            }
        }
    }
    
    // MARK: AsyncParsableCommand
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Download info, images and instructions for almost every LEGO set.", discussion: .discussion, subcommands: [
        Get.self,
        Key.self
    ])
}

extension String {
    static var discussion: Self {
        var discussion: [Self] = [
            "Requires a free Brickset API key. Use 'getset-cli key -r' to request a key from brickset.com.",
            "",
            "DOWNLOADS: \(URL.downloads.relativePath)"
        ]
#if DEBUG
        discussion += [
            "",
            "PATH: \(Bundle.main.executablePath!)"
        ]
#endif
        return discussion.joined(separator: "\n")
    }
    
    func leftPadded(to length: Int = .maxSetNumberLength, with character: Character = " ") -> Self {
        "\("".padding(toLength: max(length - count, 0), withPad: "\(character)", startingAt: 0))\(self)"
    }
}

extension Int {
    static let maxSetNumberLength: Self = 6 // LEGO/Bricklink set number length limit
}
