#if canImport(Cocoa)
import Cocoa
#else
import Foundation
#endif
import ArgumentParser
@testable import Brickset

@main
struct BrickCLI: AsyncParsableCommand {
    struct Key: ParsableCommand {
        @Argument(help: "Set API key.") var key: String?
#if canImport(Cocoa)
        @Flag(name: .shortAndLong, help: "Request an API key.") var request: Bool = false
#endif
        @Flag(name: .shortAndLong, help: "Show key in plain text.") var show: Bool = false
        @Flag(name: .shortAndLong, help: "Delete API key.") var delete: Bool = false
        
        // MARK: ParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Set Brickset API key.")
        
        func run() throws {
            if let key, !key.isEmpty {
                try URLCredentialStorage.shared.setAPIKey(key, persistence: .permanent)
            }
            if delete {
                try URLCredentialStorage.shared.setAPIKey(nil)
            }
#if canImport(Cocoa)
            if request {
                NSWorkspace.shared.open(.requestAPIKey)
            }
#endif
            if let key = URLCredentialStorage.shared.apiKey {
                print("API key: \(key.redacted(!show))")
            } else {
                print("API key not set")
            }
        }
    }
    
    // MARK: ParsableCommand
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Command-line interface to the Brickset API", discussion: "Requires a free Brickset API key.", subcommands: [
        Key.self
    ])
}
