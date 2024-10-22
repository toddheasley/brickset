import ArgumentParser
import Brickset
import Foundation
#if os(macOS)
import Cocoa
#endif

@main
struct BricksetCLI: AsyncParsableCommand {
    struct Docs: AsyncParsableCommand {
        @Flag(name: .shortAndLong, help: "Open documentation in browser.") var open: Bool = false
        
        // MARK: ParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Read Brickset API version 3 documentation.")
        
        func run() async throws {
            open(open, url: .documentation)
        }
    }
    
    struct Search: AsyncParsableCommand {
        @Argument(help: "Set search query.") var query: String?
        
        // MARK: AsyncParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Search LEGO sets by number, name and theme.")
        
        func run() async throws {
            guard let query, !query.isEmpty else {
                print("Search query not found")
                return
            }
            let sets: ([Sets], Int?) = try await URLSession.shared.getSets(GetSets(query: query, pageSize: .maxPageSize))
            let count: (Int, Int) = (sets.0.count, sets.1 ?? 0)
            print("\(count.0)\(count.1 > count.0 ? " (of \(count.1))" : "") \(count.0 != 1 ? "sets" : "set") matched \"\(query)\"\(count.0 > 0 ? ":" : "")")
            for set in sets.0 {
                print("➤\(set.number.leftPadded()) \(set.name)")
            }
        }
    }
    
    struct Build: AsyncParsableCommand {
        @Argument(help: "Specify LEGO set number.") var number: String?
        @Flag(name: .shortAndLong, help: "Open instructions in browser.") var open: Bool = false
        
        // MARK: AsyncParsableCommand
        static let configuration: CommandConfiguration = CommandConfiguration(abstract: "View instructions for a LEGO set.")
        
        func run() async throws {
            guard let number: String = number?.setNumber, !number.isEmpty else {
                print("Set number not found")
                return
            }
            let instructions: [Instructions] = try await URLSession.shared.getInstructions(set: number).0
            guard !instructions.isEmpty else {
                print("No instructions found for set \(number)")
                return
            }
            for url in instructions.map({ $0.URL }) {
                open(open, url: url)
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
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Command-line interface to the Brickset API", discussion: .discussion, subcommands: [
        Docs.self,
        Search.self,
        Build.self,
        Key.self
    ])
}

extension String {
    static var discussion: Self {
        var discussion: [Self] = [
            "Requires a free Brickset API key, which can be requested from brickset.com using 'brickset-cli key --request'."
        ]
#if DEBUG
        discussion += [
            "",
            "PATH: \(Bundle.main.executablePath!)"
        ]
#endif
        return discussion.joined(separator: "\n")
    }
    
    var setNumber: Self? { trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "-").first }
    
    func leftPadded(to length: Int = .maxSetNumberLength, with character: Character = " ") -> Self {
        "\("".padding(toLength: max(length - count, 0), withPad: "\(character)", startingAt: 0))\(self)"
    }
    
    func colorCoded(for status: APIKeyStatus = .unknown) -> Self {
        "\(status)\(self)\(APIKeyStatus.unknown)"
    }
}

extension Int {
    static let maxSetNumberLength: Self = 6 // LEGO/Bricklink set number length limit
    static let maxPageSize: Self = 500 // Brickset API boundary
}

enum APIKeyStatus: Int, CaseIterable, CustomStringConvertible {
    case valid = 32 // Green
    case invalid = 31 // Red
    case unknown = 0
    
    static var current: Self {
        get async {
            do {
                try await URLSession.shared.checkKey()
                return .valid
            } catch Error.invalidAPIKey {
                return .invalid
            } catch {
                return .unknown
            }
        }
    }
    
    // MARK: CustomStringConvertible
    var description: String { "\u{001B}[0;\(rawValue)m" }
}

extension AsyncParsableCommand {
    func open(_ open: Bool = false, url: URL) {
#if os(macOS)
        if open {
            NSWorkspace.shared.open(url)
        }
#endif
        print(url.absoluteString)
    }
}
