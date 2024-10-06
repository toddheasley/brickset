import Cocoa
import ArgumentParser
import Brickset

@main
struct Main: AsyncParsableCommand {
    
    // MARK: ParsableCommand
    nonisolated(unsafe) static var configuration: CommandConfiguration = CommandConfiguration(abstract: "Update Boats schedules.")
    
    func run() async throws {
        print("Hello, world!")
    }
}
