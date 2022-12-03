@testable import advent_of_code
import XCTest

extension String {
    var split: [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: self.count / 2, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}

final class DayThreeTests: XCTestCase {
    
    func testFirstPart() {
        var points = [String: Int]()
        
        let startChar = Unicode.Scalar("a").value
        let endChar = Unicode.Scalar("z").value

        (startChar...endChar).enumerated().forEach { tuple in
            if let char = Unicode.Scalar(tuple.1) {
                points[String(char)] = tuple.0 + 1
            }
        }
        
        let startChar1 = Unicode.Scalar("A").value
        let endChar1 = Unicode.Scalar("Z").value

        (startChar1...endChar1).enumerated().forEach { tuple in
            if let char = Unicode.Scalar(tuple.1) {
                points[String(char)] = tuple.0 + 1 + 26
            }
        }
        
        XCTAssertEqual(points.count, 52)
        
        let parsed = Parser.parse(.content(day: "Three"), separator: "\n").dropLast()
        
        var priorities = 0
        
        parsed.forEach { letters in
            let divided = letters.split
            
            if let first = divided.first, let second = divided.last {
                let output = Set(first.filter(second.contains))
                
                if let value = points[String(output)] {
                    priorities += value
                } else { fatalError() }
            } else { fatalError() }
        }
        
        XCTAssertEqual(priorities, 8053)
    }
    
    func testSecondPart() {
    }
}
