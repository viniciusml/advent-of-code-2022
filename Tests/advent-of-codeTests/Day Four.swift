@testable import advent_of_code
import XCTest

extension ClosedRange {
    func embraces(_ other: Self) -> Bool {
        return other.clamped(to: self) == other
    }
}

final class DayFourTests: XCTestCase {
    
    func testFirstPart() {
        let parsed = Parser.parse(.content(day: "Four"), separator: "\n")
        
        let ranges = ranges(from: parsed)
        
        let result = result(from: ranges) { range in
            range[0].embraces(range[1]) || range[1].embraces(range[0])
        }
        
        XCTAssertEqual(result.count, 477)
    }
    
    func testSecondPart() {
        let parsed = Parser.parse(.content(day: "Four"), separator: "\n")
        
        let ranges = ranges(from: parsed)
        
        let result = result(from: ranges) { range in
            range[1].overlaps(range[0])
        }
        
        XCTAssertEqual(result.count, 830)
    }
    
    private func ranges(from input: [String]) -> [[ClosedRange<Int>]] {
        input.map { line in
            let pairs = line.components(separatedBy: ",")
            return pairs.map { pair in
                let initialAndFinal = pair.components(separatedBy: "-")
                if let first = initialAndFinal.first, let final = initialAndFinal.last, let intFirst = Int(first), let intFinal = Int(final) {
                    return (intFirst...intFinal)
                } else { fatalError() }
            }
        }
    }
    
    private func result(from ranges: [[ClosedRange<Int>]], condition: ([ClosedRange<Int>]) -> (Bool)) -> [Bool] {
        ranges.map { range in
            condition(range)
        }.filter { $0 == true }
    }
}
