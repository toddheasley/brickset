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
        html.append("<table>")
        html.append("    <tr>")
        html.append("        <td><b>Ages \(set.ageRange)</b></td>")
        html.append("    </tr>")
        if let pieces: Int = set.pieces {
            html.append("    <tr>")
            html.append("        <td>\(pieces) pcs/pzs</td>")
            html.append("    </tr>")
        }
        html.append("</table>")
        if !images.isEmpty {
            html.append("<h2>Images</h2>")
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
            html.append("<h2>Building Instructions</h2>")
            html.append("<ul>")
            for instructions in self.instructions {
                html.append("    <li><a href=\"\(instructions.URL.absoluteString)\">\(instructions)</a></li>")
            }
            html.append("</ul>")
        }
        html.append("<h2>Details</h2>")
        html.append("<table>")
        html.append("    <tr>")
        html.append("        <td>Theme:</td>")
        if let subtheme: String = set.subtheme, !subtheme.isEmpty {
            html.append("        <td>\(set.theme) \(subtheme)</td>")
        } else {
            html.append("        <td>\(set.theme)</td>")
        }
        html.append("    </tr>")
        html.append("    <tr>")
        html.append("        <td>Released:</td>")
        html.append("        <td>\(set.year)</td>")
        html.append("    </tr>")
        if let minifigs: Int = set.minifigs, minifigs > 0 {
            html.append("    <tr>")
            html.append("        <td>Minifigs:</td>")
            html.append("        <td>\(minifigs)</td>")
            html.append("    </tr>")
        }
        html.append("    <tr>")
        html.append("        <td>Brickset ID:</td>")
        html.append("        <td><a href=\"\(set.bricksetURL.absoluteString)\">\(set.setID)</a></td>")
        html.append("    </tr>")
        
        
        html.append("</table>")
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

private let style: String = """
    
    :root {
        color-scheme: light dark;
        -webkit-text-size-adjust: none;
    }
    
    /*
    body {
        font: 1em ui-sans-serif, sans-serif;
    } */
    
    img {
        max-height: 384px;
    }
    
    section {
        border: 2.5px solid;
        max-width: 768px;
        overflow-x: scroll;
    }
    
    section table {
        border-spacing: 1em;
    }

"""
