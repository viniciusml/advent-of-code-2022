import Foundation

extension Bundle {
    public static var aoc: Bundle = .module
}

extension String {
    
    static func content(day: String) -> String {
        guard let path = Bundle.aoc.path(forResource: "Day \(day)", ofType: "txt", inDirectory: "Resources") else {
            return "no path"
        }
        
        let string = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return string
    }
}

final class Parser {
    
    static func parse(_ txt: String, separator: String) -> [String] {
        txt.components(separatedBy: separator)
    }
}
