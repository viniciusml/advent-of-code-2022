@testable import advent_of_code
import XCTest

extension String {
    var digits: [String] {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
    }
}

final class DayFiveTests: XCTestCase {
    
    struct Direction {
        let quantity: Int
        let origin: Int
        let destination: Int
    }
    
    var crates: [Int: [String]] = [
        1: ["D", "T", "R", "B", "J", "L", "W", "G"],
        2: ["S", "W", "C"],
        3: ["R", "Z", "T", "M"],
        4: ["D", "T", "C", "H", "S", "P", "V"],
        5: ["G", "P", "T", "L", "D", "Z"],
        6: ["F", "B", "R", "Z", "J", "Q", "C", "D"],
        7: ["S", "B", "D", "J", "M", "F", "T", "R"],
        8: ["L", "H", "R", "B", "T", "V", "M"],
        9: ["Q", "P", "D", "S", "V"]
    ]
    
    func testFirstPart() {
        let parsed = Parser.parse(.content(day: "Five"), separator: "\n")
        
        let directions = parsed.map { $0.digits }
        let directionsIntegers = directions.map { strings in
            strings.compactMap { Int($0) }
        }
        let parsedDirections = directionsIntegers.map {
            XCTAssertEqual($0.count, 3)
            return Direction(quantity: $0[0], origin: $0[1], destination: $0[2])
        }
        
        parsedDirections.forEach { direction in
            for _ in (1...direction.quantity) {
                
                guard var originCopy = crates[direction.origin], var destinationCopy = crates[direction.destination] else {
                    fatalError()
                }
                
                if let last = originCopy.popLast() {
                    destinationCopy.append(last)
                } else { fatalError() }
                
                crates[direction.origin] = originCopy
                crates[direction.destination] = destinationCopy
            }
        }
        
        var topOfStacks = ""
        for index in (1...9) {
            let last = crates[index]?.last!
            topOfStacks.append(last!)
        }
        
        XCTAssertEqual(topOfStacks, "")
    }
    
    func testSecondPart() {
        let parsed = Parser.parse(.content(day: "Five"), separator: "\n")
    }
}
