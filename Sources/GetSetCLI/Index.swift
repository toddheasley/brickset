import Foundation
import GetSet

struct Index: CustomStringConvertible {
    static let path: String = "index.html"
    
    let set: Sets
    let instructions: [Instructions]
    let images: [Sets.Image]
    
    var data: Data { html.data(using: .utf8)! }
    
    var html: String {
        var html: [String] = []
        html.append("<!DOCTYPE html>")
        html.append("<title>\(set)</title>")
        html.append("<meta name=\"viewport\" content=\"initial-scale=1.0\">")
        html.append("<meta charset=\"UTF-8\">")
        html.append("<h1>\(set.path)<br><small>\(set.name)</small></h1>")
        html.append("<p><b>Ages \(set.ageRange)</b><br>\(set.pieces ?? 0) pcs/pzs</p>")
        if !images.isEmpty {
            html.append("<section>")
            html.append("    <table>")
            html.append("        <tr>")
            for image in images {
                guard let src: String = image.imageURL?.absoluteString else { continue }
                html.append("            <td><a href=\"\(src)\"><img src=\"\(src)\"></a></td>")
            }
            html.append("        </tr>")
            html.append("    </table>")
            html.append("</section>")
        }
        if !instructions.isEmpty {
            html.append("<ul>")
            for instructions in self.instructions {
                html.append("    <li><a href=\"\(instructions.URL.absoluteString)\">\(instructions)</a></li>")
            }
            html.append("</ul>")
        }
        html.append("<p><a href=\"\(set.bricksetURL.absoluteString)\">\(set.bricksetURL.string)</a></p>")
        html.append("<style>")
        html.append(style)
        html.append("</style>")
        return html.joined(separator: "\n")
    }
    
    init(set: Sets, instructions: [Instructions] = [], images: [Sets.Image] = []) {
        self.set = set
        self.instructions = instructions
        self.images = images
    }
    
    // MARK: CustomStringConvertible
    var description: String { self.set.description }
}

extension URL {
    var string: String { absoluteString.components(separatedBy: "//").last! }
}

private let style: String = """
    
    :root {
        color-scheme: light dark;
    }
    
    body {
        font: 1em ui-sans-serif, sans-serif;
    }
    
    img {
        max-height: 320px;
    }
    
    section {
        border: 1px solid gray;
        overflow-x: scroll;
    }
    
"""
