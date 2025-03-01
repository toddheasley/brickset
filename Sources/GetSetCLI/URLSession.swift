import Foundation
import GetSet

extension URLSession {
    func getSet(_ set: Sets, download: Bool = false) async throws -> URL {
        print(set)
        let url: URL = .downloads.appending(path: set.path)
        if !FileManager.default.fileExists(atPath: url.path()) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        var instructions: [Instructions] = []
        if set.instructionsCount > 0 {
            instructions += try await getInstructions(set: set.setID).0
        }
        var images: [Sets.Image] = [
            set.image
        ]
        if set.additionalImageCount > 0 {
            images += try await getAdditionalImages(set: set.setID).0.compactMap { $0.imageURL != nil ? $0 : nil }
        }
        for (index, instruction) in instructions.enumerated() {
            instructions[index] = try await self.download(download, instructions: instruction, to: url)
        }
        for (index, image) in images.enumerated() {
            images[index] = try await self.download(download, image: image, to: url)
        }
        try Index(set: set, instructions: instructions, images: images).data.write(to: url.appending(path: Index.path))
        return url.appending(path: Index.path)
    }
    
    func download(_ download: Bool = true, instructions: Instructions, to url: URL) async throws -> Instructions {
        guard download else { return instructions }
        let directoryURL: URL = try FileManager.default.createDirectory("instructions", at: url)
        guard let url: URL = URL(string: "instructions/\(instructions.URL.lastPathComponent)") else {
            throw URLError(.badURL)
        }
        print("downloading \(url.path())")
        let data: Data = try await self.data(from: instructions.URL).0
        try data.write(to: directoryURL.appending(path: instructions.URL.lastPathComponent))
        return Instructions("\(instructions.description.components(separatedBy: " (").first!)", url: url)
    }
    
    func download(_ download: Bool = true, image: Sets.Image, to url: URL) async throws -> Sets.Image {
        guard download,
              let imageURL: URL = image.imageURL else {
            return image
        }
        let directoryURL: URL = try FileManager.default.createDirectory("images", at: url)
        guard let url: URL = URL(string: "images/\(imageURL.lastPathComponent)") else {
            throw URLError(.badURL)
        }
        print("downloading \(url.path())")
        let data: Data = try await self.data(from: imageURL).0
        try data.write(to: directoryURL.appending(path: imageURL.lastPathComponent))
        return Sets.Image(url)
    }
}

extension URL {
    static var downloads: Self {
#if os(macOS)
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Downloads")
#else
        fatalError()
#endif
    }
}

extension FileManager {
    func createDirectory(_ path: String, at url: URL) throws -> URL {
        let url: URL = url.appending(path: path)
        if !fileExists(atPath: url.path()) {
            try createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url
    }
}
