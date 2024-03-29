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

typealias Points = [String: Int]

extension Points {
    
    static var make: Self {
        var points = [String: Int]()
        
        points.from("a", to: "z")
        points.from("A", to: "Z", addition: 26)
        
        assert(points.count == 52)
        return points
    }
    
    mutating func from(_ initial: String, to last: String, addition: Int = 0) {
        let startChar = Unicode.Scalar(initial)!.value
        let endChar = Unicode.Scalar(last)!.value

        (startChar...endChar).enumerated().forEach { tuple in
            if let char = Unicode.Scalar(tuple.1) {
                self[String(char)] = tuple.0 + 1 + addition
            }
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

final class DayThreeTests: XCTestCase {
    
    func testFirstPart() {
        let points = Points.make
        
        let parsed = Parser.parse(.content(day: "Three"), separator: "\n")
        
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
        let points = Points.make
        
        let parsed = Parser.parse(.content(day: "Three"), separator: "\n")
        let groupsOfThree = Array(parsed).chunked(into: 3)
        
        XCTAssertEqual(groupsOfThree.count, 100)
        
        var priorities = 0
        
        groupsOfThree.forEach { letters in

            if let first = letters[safeIndex: 0], let second = letters[safeIndex: 1], let third = letters[safeIndex: 2] {
                let output = Set(first.filter(second.contains).filter(third.contains))

                if let value = points[String(output)] {
                    priorities += value
                } else { fatalError() }
            } else { fatalError() }
        }
        
        XCTAssertEqual(priorities, 2425)
    }
}
