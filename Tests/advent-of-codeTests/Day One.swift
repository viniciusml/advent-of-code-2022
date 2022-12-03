@testable import advent_of_code
import XCTest

final class DayOneTests: XCTestCase {
    
    func testFirstPart() {
        let elves = Parser.parse(.content(day: "One"), separator: "\n\n")
        
        let result = elves.map { elf in
            elf.components(separatedBy: "\n").compactMap { Int($0) }.reduce(0, +)
        }
        
        XCTAssertEqual(result.sorted().last, 64929)
    }
    
    func testSecondPart() {
        let elves = Parser.parse(.content(day: "One"), separator: "\n\n")
        
        let result = elves.map { elf in
            elf.components(separatedBy: "\n").compactMap { Int($0) }.reduce(0, +)
        }
        
        var copy = result.sorted()
        let threeLastElves = [copy.popLast(), copy.popLast(), copy.popLast()].compactMap { $0 }
        XCTAssertEqual(threeLastElves.reduce(0, +), 193697)
    }
}
