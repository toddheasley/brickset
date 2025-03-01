import ArgumentParser
#if canImport(Cocoa)
import Cocoa
#else
import Foundation
#endif

extension AsyncParsableCommand {
    func open(_ open: Bool = true, url: URL) {
#if canImport(Cocoa)
        if open {
            NSWorkspace.shared.open(url)
        }
#else
        print(url.absoluteString)
#endif
    }
}
