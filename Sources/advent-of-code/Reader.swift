import Foundation

extension Bundle {
    public static var aoc: Bundle = .module
}

extension String {
    
    static var content: String {
        let path = Bundle.aoc.path(forResource: "Day One", ofType: "txt", inDirectory: "Resources")
        let string = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return string
    }
}

final class Parser {
    
    static func parse(_ txt: String) -> [String] {
        txt.components(separatedBy: "\n\n")
    }
}
